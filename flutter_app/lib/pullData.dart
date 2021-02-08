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
    getUsageStats();
  }

  void getUsageStats() async {
    try {
      DateTime endDate = new DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours: 24));
      List<AppUsageInfo> infoList = await AppUsage.getAppUsage(startDate, endDate);
      infoList.sort((a, b) => b.usage.inSeconds.compareTo(a.usage.inSeconds));
      setState(() {
        _infos = infoList;  
      });
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
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
              if ((_infos[index].usage.inMinutes%60) > 5) {
                return ListTile(
                    title: Text(_infos[index].appName, style: TextStyle(color: Colors.orangeAccent,letterSpacing: 1.5,fontSize: 18.0,),),
                    trailing: Text((_infos[index].usage.inMinutes~/60).toString() + ':' + (_infos[index].usage.inMinutes%60).toString().padLeft(2,'0'),style: TextStyle(color: Colors.tealAccent,letterSpacing: 1.5,fontSize: 18.0,),),
                );
              }
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: getUsageStats, child: Icon(Icons.refresh), backgroundColor: Colors.tealAccent, foregroundColor: Colors.grey[850],
        ),
    );
  }
}