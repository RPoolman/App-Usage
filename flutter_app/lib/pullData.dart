import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<AppUsageInfo> _infos = [];

  @override
  void initState() {
    super.initState();
  }

  void getUsageStats() async {
    try {
      DateTime endDate = new DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours: 24));
      List<AppUsageInfo> infoList = await AppUsage.getAppUsage(startDate, endDate);
      setState(() {
        _infos = infoList;
      });
    } on AppUsageException catch (exception) {
      print(exception);
    }
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
        body:
        ListView.builder(
            itemCount: _infos.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(_infos[index].appName),
                  trailing: Text((_infos[index].usage.inMinutes~/60).toString() + ':' + (_infos[index].usage.inMinutes%60).toString())
              );
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: getUsageStats, child: Icon(Icons.refresh)),

        ),
    );
  }
}