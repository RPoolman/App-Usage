import 'package:flutter/material.dart';

import 'package:flutter_app/screens/homePage.dart';
import 'package:flutter_app/screens/analiticsPage.dart';

import 'package:flutter_app/classes/deviceExtrapolation.dart';
import 'package:flutter_app/classes/deviceVars.dart';

class DeviceApps extends StatefulWidget {
  @override
  _DeviceAppsState createState() => _DeviceAppsState();
}
class _DeviceAppsState extends State<DeviceApps> {
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
                      (route) => false
              );},
            ),
            SizedBox(width: 20,),
            IconButton(icon: Icon(Icons.list_alt, color: Colors.indigo,), onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => DeviceApps()),
                      (route) => false
              );},
            ),
            SizedBox(width: 20,),
            IconButton(icon: Icon(Icons.person), onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => StatScreen()),
                      (route) => false
              );},
            ),
          ],
        ),
      ),
      body:
        Padding(
          padding: EdgeInsets.fromLTRB(0, 30.0, 0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: <Widget>[
                      Text(
                        GlobalData.userTrackedName + '\'s usage thus far:',
                        style: TextStyle(color: Colors.indigo,letterSpacing: 2.0,fontSize: 22.0,),
                      ),
                      SizedBox(height: 20),
                      Icon(
                        Icons.timer_sharp,
                        color: Colors.redAccent,
                        size: 50,
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
                    itemCount: DeviceData.infosDay.length,
                    itemBuilder: (context, index) {
                      if ((DeviceData.infosDay[index].usage.inMinutes) > 1) {
                        return ListTile(
                            title: Text(DeviceData.infosDay[index].appName, style: TextStyle(color: Colors.indigo,letterSpacing: 1.5,fontSize: 18.0,),),
                            trailing: Text((DeviceData.infosDay[index].usage.inHours).toString() + ':' + (DeviceData.infosDay[index].usage.inMinutes%60).toString().padLeft(2,'0'),style: TextStyle(color: Colors.redAccent,letterSpacing: 1.5,fontSize: 18.0,),),
                        );
                      }
                    },),
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed:
        DeviceData.refreshUsageStats,
        child: Icon(Icons.refresh),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
    );
  }
}