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
  DeviceData.getUsageStats();
  print("App time: ${GlobalData.applicationList[0]}");
  // the line below might be triggering my task to stop
  // BackgroundFetch.finish(taskId);
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
    int status = await BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 3,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE
    ), (String taskId) async {
      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      setState(() {
        //this state gets called
        print("======================$taskId====================");
        DeviceData.getUsageStats();
        print(GlobalData.app1Time);
      });
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      print("=============[BackgroundFetch] TASK TIMEOUT taskId: $taskId=============");
      BackgroundFetch.finish(taskId);
    });
    print("============Configuration happens smoothly==============");
    setState(() {
      print("===============WHat will be called here=============");
    });
    if (!mounted) {
      print("=============Got discarded==============");
      return;
    }
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

