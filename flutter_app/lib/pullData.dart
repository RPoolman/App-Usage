import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<AppUsageInfo> _infos = [];

  @override
  void initState() {
    super.initState();
  }

  Future getUsageStats() async {
    try {
      DateTime initialDate = new DateTime.now();
      DateTime endDate = initialDate.subtract(Duration(minutes: 3));
      DateTime startDate = endDate.subtract(Duration(minutes: 30));
      List<AppUsageInfo> infoList = await AppUsage.getAppUsage(startDate, endDate);
      print('Hope it gets fixed.');
      setState(() {
        _infos = infoList;

        print(infoList.length);

        for(var info in infoList) {
          var aName = '';
          aName = info.appName.toString();
          print(aName);
          print(info.packageName.toString());
        }
        // String get appName;
        // String get packageName;
        // Duration get usage;
        // DateTime get startDate;
        // DateTime get endDate;
      });

      for(var info in infoList) {
        print(info.appName.toString());
        print(info.packageName.toString());
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage Example'),
          backgroundColor: Colors.green,
        ),
        body: ListView.builder(
            itemCount: _infos.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(_infos[index].appName),
                  trailing: Text(_infos[index].usage.toString()));
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: getUsageStats, child: Icon(Icons.list)),
      ),
    );
  }
}