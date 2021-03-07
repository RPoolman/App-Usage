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

void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool timeout = task.timeout;
  if (timeout) {
    BackgroundFetch.finish(taskId);
    return;
  }
  DateTime timestamp = DateTime.now();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> events = [];
  String json = prefs.getString(EVENTS_KEY);
  if (json != null) {
    events = jsonDecode(json).cast<String>();
  }
  events.insert(0, "$taskId@$timestamp [Headless]");
  prefs.setString(EVENTS_KEY, jsonEncode(events));

  if (taskId == 'flutter_background_fetch') {
    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: "apptracking-task",
        delay: 5000,
        periodic: false,
        forceAlarmManager: false,
        stopOnTerminate: false,
        enableHeadless: true
    ));
   }
  BackgroundFetch.finish(taskId);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    DeviceData.getUsageStats();
    print('called in future -> ${GlobalData.app2Time}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = prefs.getString(EVENTS_KEY);
    if (json != null) {
      setState(() {
        _events = jsonDecode(json).cast<String>();
      });
    }
    try {
      int status = await BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 1,
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
      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "apptracking-task",
          delay: 10000,
          periodic: true,
          forceAlarmManager: true,
          stopOnTerminate: false,
          enableHeadless: true
      ));
    } catch(e) {
      print('[BackgroundFetch] configure ERROR: $e');
    }
    if (!mounted) return;
  }
  void _onBackgroundFetch(String taskId) async {
    //work in this method
    print('*****************************reference point for task called.');
    DeviceData.getUsageStats();
    print('called in func -> ${GlobalData.app2Time}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      DeviceData.getUsageStats();
      print('called in state -> ${GlobalData.app2Time}');
    });
    prefs.setString(EVENTS_KEY, jsonEncode(_events));
    if (taskId == "apptracking-task") {
      BackgroundFetch.configure(BackgroundFetchConfig(
          minimumFetchInterval: 3,
          stopOnTerminate: false,
          forceAlarmManager: true
      ), (String taskId) async {
        DeviceData.getUsageStats();
        print('in config -> ${GlobalData.app2Time}');
        BackgroundFetch.finish(taskId);
      }, (String taskId) async {  BackgroundFetch.finish(taskId);  });
      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "apptracking-task",
          delay: 10000,       // milliseconds
          periodic: true
      ));
    }
    BackgroundFetch.finish(taskId);
  }
  void _onBackgroundFetchTimeout(String taskId) {
    print("[BackgroundFetch] TIMEOUT: $taskId");
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

