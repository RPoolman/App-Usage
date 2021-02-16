import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:flutter_app/main.dart';
import 'deviceVars.dart';
import 'Stats.dart';

class DeviceApps extends StatefulWidget {
  @override
  _DeviceAppsState createState() => _DeviceAppsState();
}
class _DeviceAppsState extends State<DeviceApps> {
  List<AppUsageInfo> _infosDay = [];
  @override
  void initState() {
    super.initState();
    getUsageStats();
  }
  void getUsageStats() async {
    try {
      DateTime endDate = new DateTime.now();
      DateTime dailyDate = endDate.subtract(new Duration(days: 1));
      List<AppUsageInfo> infoDayList = await AppUsage.getAppUsage(dailyDate, endDate);
      infoDayList.sort((a, b) => b.usage.inSeconds.compareTo(a.usage.inSeconds));
      setState(() {
        _infosDay = infoDayList;
      });
      for(int i = 0; i < 5; i++){
        GlobalData.appsGraph[i] = infoDayList[i].usage.inHours;
      }
      var listLen = infoDayList.length;
      switch(listLen) {
        case 0: { GlobalData.app1Name = ""; }
        break;
        case 1: {
          GlobalData.app1Name = infoDayList[0].appName;
          GlobalData.app1Time = (infoDayList[0].usage.inHours).toString() + ':' + (infoDayList[0].usage.inMinutes%60).toString().padLeft(2,'0');
        }
        break;
        case 2: {
          GlobalData.app1Name = infoDayList[0].appName;
          GlobalData.app1Time = (infoDayList[0].usage.inHours).toString() + ':' + (infoDayList[0].usage.inMinutes%60).toString().padLeft(2,'0');
          GlobalData.app2Name = infoDayList[1].appName;
          GlobalData.app2Time = (infoDayList[1].usage.inHours).toString() + ':' + (infoDayList[1].usage.inMinutes%60).toString().padLeft(2,'0');
        }
        break;
        default: {
          GlobalData.app1Name = infoDayList[0].appName;
          GlobalData.app1Time = (infoDayList[0].usage.inHours).toString() + ':' + (infoDayList[0].usage.inMinutes%60).toString().padLeft(2,'0');
          GlobalData.app2Name = infoDayList[1].appName;
          GlobalData.app2Time = (infoDayList[1].usage.inHours).toString() + ':' + (infoDayList[1].usage.inMinutes%60).toString().padLeft(2,'0');
          GlobalData.app3Name = infoDayList[2].appName;
          GlobalData.app3Time = (infoDayList[2].usage.inHours).toString() + ':' + (infoDayList[2].usage.inMinutes%60).toString().padLeft(2,'0');
        }
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('App Tracker',style: TextStyle(color: Colors.white,letterSpacing: 0.8, fontSize: 28,)),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          elevation: 0,
        ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
              );},
            ),
            SizedBox(width: 20,),
            IconButton(icon: Icon(Icons.list_alt), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeviceApps()),
              );},
            ),
            SizedBox(width: 20,),
            IconButton(icon: Icon(Icons.person), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatScreen()),
              );},
            ),
          ],
        ),
      ),
        body:
        ListView.builder(
          padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
            itemCount: _infosDay.length,
            itemBuilder: (context, index) {
              if ((_infosDay[index].usage.inMinutes) > 5) {
                return ListTile(
                    title: Text(_infosDay[index].appName, style: TextStyle(color: Colors.indigo,letterSpacing: 1.5,fontSize: 18.0,),),
                    trailing: Text((_infosDay[index].usage.inHours).toString() + ':' + (_infosDay[index].usage.inMinutes%60).toString().padLeft(2,'0'),style: TextStyle(color: Colors.redAccent,letterSpacing: 1.5,fontSize: 18.0,),),
                );
              }
            },),
      floatingActionButton: FloatingActionButton(
        onPressed:
        getUsageStats,
        child: Icon(Icons.refresh),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
    );
  }
}