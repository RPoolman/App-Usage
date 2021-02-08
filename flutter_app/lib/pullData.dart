// import 'package:flutter/material.dart';
// import 'package:app_usage/app_usage.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => new _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   List<AppUsageInfo> _infos = [];
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Future getUsageStats() async {
//     try {
//       DateTime initialDate = new DateTime.now();
//       DateTime endDate = initialDate.subtract(Duration(minutes: 3));
//       DateTime startDate = endDate.subtract(Duration(minutes: 30));
//       List<AppUsageInfo> infoList = await AppUsage.getAppUsage(startDate, endDate);
//       print('Hope it gets fixed.');
//       setState(() {
//         _infos = infoList;
//
//         print(infoList.length);
//
//         for(var info in infoList) {
//           var aName = '';
//           aName = info.appName.toString();
//           print(aName);
//           print(info.packageName.toString());
//         }
//         // String get appName;
//         // String get packageName;
//         // Duration get usage;
//         // DateTime get startDate;
//         // DateTime get endDate;
//       });
//
//       for(var info in infoList) {
//         print(info.appName.toString());
//         print(info.packageName.toString());
//       }
//     } on AppUsageException catch (exception) {
//       print(exception);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('App Usage Example'),
//           backgroundColor: Colors.orangeAccent,
//         ),
//         body: ListView.builder(
//             itemCount: _infos.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                   title: Text(_infos[index].appName),
//                   trailing: Text(_infos[index].usage.toString()));
//             }),
//         floatingActionButton: FloatingActionButton(
//             onPressed: getUsageStats, child: Icon(Icons.list)),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:usage_stats/usage_stats.dart';

// void main() => runApp(MyApp());
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   List<AppUsageInfo> _infos = [];
//
//   @override
//   void initState() {
//     super.initState();
//     getUsageStats();
//   }
//
//   void getUsageStats() async {
//     try {
//       DateTime endDate = new DateTime.now();
//       DateTime startDate = endDate.subtract(Duration(hours: 1));
//       List<AppUsageInfo> infoList = await AppUsage.getAppUsage(startDate, endDate);
//       setState(() {
//         _infos = infoList;
//       });
//
//       for (var info in infoList) {
//         print(info.toString());
//       }
//     } on AppUsageException catch (exception) {
//       print(exception);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('App Tracker',style: TextStyle(color: Colors.grey[850],letterSpacing: 0.8, fontSize: 28,)),
//           centerTitle: true,
//           backgroundColor: Colors.orangeAccent,
//           elevation: 0,
//         ),
//         body: ListView.builder(
//             itemCount: _infos.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                   title: Text(_infos[index].appName),
//                   trailing: Text(_infos[index].usage.toString()));
//             }),
//     )
//     );
//   }
// }
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