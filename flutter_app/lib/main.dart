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
        taskId: "rikus-task",
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
  bool _enabled = true;
  int _status = 0;
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
      setState(() {
        _status = status;
      });
      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "rikus-task",
          delay: 10000,
          periodic: true,
          forceAlarmManager: true,
          stopOnTerminate: false,
          enableHeadless: true
      ));
    } catch(e) {
      print('[BackgroundFetch] configure ERROR: $e');
      setState(() {
        _status = e;
      });
    }
    if (!mounted) return;
  }
  void _onBackgroundFetch(String taskId) async {
    print('******************************************GETTING');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime timestamp = new DateTime.now();
    print("[BackgroundFetch] Event received: $taskId");
    setState(() {
      _events.insert(0, "$taskId@${timestamp.toString()}");
    });
    prefs.setString(EVENTS_KEY, jsonEncode(_events));
    if (taskId == "rikus-task") {
      BackgroundFetch.configure(BackgroundFetchConfig(
          minimumFetchInterval: 3,
          stopOnTerminate: false,
          forceAlarmManager: true
      ), (String taskId) async {
        DeviceData.getUsageStats();
        BackgroundFetch.finish(taskId);
      }, (String taskId) async {  BackgroundFetch.finish(taskId);  });

      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "rikus-task",
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
  void _onClickEnable(enabled) {
    print('***********************************************ENABLE');
    setState(() {
      _enabled = enabled;
    });
    if (enabled) {
      BackgroundFetch.start().then((int status) {
        print('[BackgroundFetch] start success: $status');
      }).catchError((e) {
        print('[BackgroundFetch] start FAILURE: $e');
      });
    } else {
      BackgroundFetch.stop().then((int status) {
        print('[BackgroundFetch] stop success: $status');
      });
    }
  }
  void _onClickStatus() async {
    print('***********************************************STATUS');
    int status = await BackgroundFetch.status;
    print('[BackgroundFetch] status: $status');
    setState(() {
      _status = status;
    });
  }
  void _onClickClear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(EVENTS_KEY);
    setState(() {
      _events = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    const EMPTY_TEXT = Center(child: Text('Waiting for fetch events.  Simulate one.\n [Android] \$ ./scripts/simulate-fetch\n [iOS] XCode->Debug->Simulate Background Fetch'));
    loading = true;
    if(_error) {
      loading = false;
    }
    if (!_initialized) {
      loading = true;
    }
    return StreamProvider<UserApptracker>.value(
      // value: AuthService().signedInUser,
      child: MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
              title: const Text('BackgroundFetch Example', style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.amberAccent,
              brightness: Brightness.light,
              actions: <Widget>[
                Switch(value: _enabled, onChanged: _onClickEnable),
              ]
          ),
          body: (_events.isEmpty) ? EMPTY_TEXT : Container(
            child: new ListView.builder(
                itemCount: _events.length,
                itemBuilder: (BuildContext context, int index) {
                  List<String> event = _events[index].split("@");
                  return InputDecorator(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
                          labelStyle: TextStyle(color: Colors.blue, fontSize: 20.0),
                          labelText: "[${event[0].toString()}]"
                      ),
                      child: new Text(event[1], style: TextStyle(color: Colors.black, fontSize: 16.0))
                  );
                }
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              child: Container(
                  padding: EdgeInsets.only(left: 5.0, right:5.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(onPressed: _onClickStatus, child: Text('Status: $_status')),
                        RaisedButton(onPressed: _onClickClear, child: Text('Clear'))
                      ]
                  )
              )
          ),
        ),
      ),
    );
  }
}

