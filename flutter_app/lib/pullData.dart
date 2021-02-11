import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'deviceVars.dart';

class DeviceApps extends StatefulWidget {
  @override
  _DeviceAppsState createState() => _DeviceAppsState();
}
class _DeviceAppsState extends State<DeviceApps> {
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
      var listLen = infoList.length;
      for(int appPos = 0; appPos < 5; appPos++) {
        GlobalData.appsGraph[appPos] = (infoList[appPos].usage.inSeconds/3600).round();
      }
      switch(listLen) {
        case 0: { GlobalData.app1Name = ""; }
        break;
        case 1: {
          GlobalData.app1Name = infoList[0].appName;
          GlobalData.app1Time = (infoList[0].usage.inMinutes~/60).toString() + ':' + (infoList[0].usage.inMinutes%60).toString().padLeft(2,'0');
        }
        break;
        case 2: {
          GlobalData.app1Name = infoList[0].appName;
          GlobalData.app1Time = (infoList[0].usage.inMinutes~/60).toString() + ':' + (infoList[0].usage.inMinutes%60).toString().padLeft(2,'0');
          GlobalData.app2Name = infoList[1].appName;
          GlobalData.app2Time = (infoList[1].usage.inMinutes~/60).toString() + ':' + (infoList[1].usage.inMinutes%60).toString().padLeft(2,'0');
        }
        break;
        default: {
          GlobalData.app1Name = infoList[0].appName;
          GlobalData.app1Time = (infoList[0].usage.inMinutes~/60).toString() + ':' + (infoList[0].usage.inMinutes%60).toString().padLeft(2,'0');
          GlobalData.app2Name = infoList[1].appName;
          GlobalData.app2Time = (infoList[1].usage.inMinutes~/60).toString() + ':' + (infoList[1].usage.inMinutes%60).toString().padLeft(2,'0');
          GlobalData.app3Name = infoList[2].appName;
          GlobalData.app3Time = (infoList[2].usage.inMinutes~/60).toString() + ':' + (infoList[2].usage.inMinutes%60).toString().padLeft(2,'0');
        }
      }
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