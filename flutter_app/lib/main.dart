import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pullData.dart';
import 'Stats.dart';

import 'deviceVars.dart';
import 'dataChart.dart';

void main() { runApp(MaterialApp(home: LandingPage()));}
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}
class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
            IconButton(icon: Icon(Icons.person), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatScreen()),
              );},
            ),
            SizedBox(width: 20,),
            IconButton(icon: Icon(Icons.list_alt), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeviceApps()),
              );},
            ),
          ],
        ),
      ),
      body:
      Padding(
        padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tracked: ',
                  style: TextStyle(color: Colors.blueAccent,letterSpacing: 2.0,fontSize: 18.0,),
                ),
                SizedBox(height: 4),
                Text(
                  'Gerald Storm',
                  style: TextStyle(color: Colors.redAccent,letterSpacing: 2.0,fontSize: 18.0,),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tracked by: ',
                  style: TextStyle(color: Colors.blueAccent,letterSpacing: 2.0,fontSize: 18.0,),
                ),
                SizedBox(height: 4),
                Text(
                  'Ben Storm',
                  style: TextStyle(color: Colors.redAccent,letterSpacing: 2.0,fontSize: 18.0,),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.timer_sharp,
                  color: Colors.blueAccent,
                  size: 50,
                ),
                SizedBox(width: 10,),
                Text(
                  'Todays Usage: ',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 22,
                    letterSpacing: 1,
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.app_blocking,
                  color: Colors.blueAccent,
                  size: 30,
                ),
                SizedBox(width: 10,),
                Text(
                  GlobalData.app1Time,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.app_blocking,
                  color: Colors.blueAccent,
                  size: 30,
                ),
                SizedBox(width: 10,),
                Text(
                  GlobalData.app2Time,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.app_blocking,
                  color: Colors.blueAccent,
                  size: 30,
                ),
                SizedBox(width: 10,),
                Text(
                  GlobalData.app3Time,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                      height:250,
                      child: PointsLineChart(
                        PointsLineChart.createSampleData(), animate: false,
                      ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
