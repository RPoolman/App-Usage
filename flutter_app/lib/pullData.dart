import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:usage_stats/usage_stats.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<EventUsageInfo> events;

  @override
  void initState() {
    super.initState();
    initUsage();
  }

  Future<void> initUsage() async {
    UsageStats.grantUsagePermission();
    DateTime endDate = new DateTime.now();
    DateTime startDate = DateTime(endDate.year, endDate.month, 29, 0, 0, 0);
    List<EventUsageInfo> queryEvents =
    await UsageStats.queryEvents(startDate, endDate);

    this.setState(() {
      events = queryEvents.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Tracker',style: TextStyle(color: Colors.grey[850],letterSpacing: 0.8, fontSize: 28,)),
          centerTitle: true,
          backgroundColor: Colors.orangeAccent,
          elevation: 0,
        ),
        body: Container(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(events[index].packageName),
                    subtitle: Text(
                        "Last time used: ${DateTime.fromMillisecondsSinceEpoch(int.parse(events[index].timeStamp)).toIso8601String()}"),
                    trailing: Text(events[index].eventType),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: events.length)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            initUsage();
          },
          child: Icon(
            Icons.refresh,
          ),
          mini: true,
        ),
      ),
    );
  }
}