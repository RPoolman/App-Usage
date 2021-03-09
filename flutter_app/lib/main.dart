import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/services/servicesAuth.dart';
import 'package:flutter_app/shared/loading.dart';

import 'classes/deviceExtrapolation.dart';
import 'classes/deviceVars.dart';

import 'package:background_fetch/background_fetch.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';
import 'services/traffic.dart';

const EVENTS_KEY = "fetch_events";

// This "Headless Task" is run when app is terminated
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool timeout = task.timeout;
  if (timeout) {
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  BackgroundFetch.finish(taskId);
}

void main() {
  runApp(Apptracker());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class Apptracker extends StatefulWidget {
  _ApptrackerState createState() => _ApptrackerState();
}

class _ApptrackerState extends State<Apptracker> {
  bool _initialized = false;
  bool _error = false;
  bool loading = false;
  List<String> _events = [];

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      setState(() {
        _error = true;
      });
    }
  }
  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    //below is default code what i got, they configure all the attributes of a task.
    try {
      int status = await BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 3,
        forceAlarmManager: false,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE,
      ), _onBackgroundFetch, _onBackgroundFetchTimeout);
      print('[BackgroundFetch] configure success: $status');
      //over here i just try to create a small periodic schedule for my task.
      //the delay of 30000 is in milliseconds, thus every 30 seconds
      //i got data from the console when printing that show this timing kicking of every time.
      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "apptracking-task",
          delay: 30000,
          periodic: true,
          stopOnTerminate: false,
          enableHeadless: true,
          forceAlarmManager: true,
      ));
    } catch(e) {
      print('[BackgroundFetch] configure ERROR: $e');
    }
    // if (!mounted) return;
  }
  void _onBackgroundFetch(String taskId) async {
    //shit happens in here... but not my shit.
    //this method dictates what should happen on a background call
    DateTime timestamp = new DateTime.now();
    print("[BackgroundFetch] Event received: $taskId");
    setState(() {
      print("Fired at: ${timestamp.toString()}");
      DeviceData.getUsageStats();
      print("App time: ${GlobalData.applicationList[0]}");
    });
    DeviceData.getUsageStats();
    print("**************************App time: ${GlobalData.applicationList[0]}");
    if (taskId == "apptracking-task") {
      BackgroundFetch.scheduleTask(TaskConfig(
        taskId: "apptracking-task",
        delay: 30000,
        periodic: true,
        stopOnTerminate: false,
        enableHeadless: true,
        forceAlarmManager: true,
      ));
      setState(() {DeviceData.getUsageStats();});
    }
    BackgroundFetch.finish(taskId);
  }
  void _onBackgroundFetchTimeout(String taskId) {
    BackgroundFetch.finish(taskId);
  }
  @override
  Widget build(BuildContext context) {
    loading = true;
    if(_error) {
      loading = false;
    }
    if (!_initialized) {
      loading = true;
    }
    return StreamProvider<UserApptracker>.value(
      value: AuthService().signedInUser,
      child: MaterialApp(
        home: _initialized ? Traffic() : loading ? Loading() : Traffic(),
      ),
    );
  }
}

