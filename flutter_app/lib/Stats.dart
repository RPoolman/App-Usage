import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

import 'pullData.dart';

import 'deviceVars.dart';

class StatScreen extends StatefulWidget {
  @override
  _StatScreenState createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
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
      body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Gerald Storm',
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
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Daily Usage: ',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  GlobalData.app1Time,
                  style: TextStyle( color: Colors.indigo, fontSize: 16, letterSpacing: 1, ),
                ),
                Text(
                  GlobalData.app2Time,
                  style: TextStyle( color: Colors.indigo, fontSize: 16, letterSpacing: 1, ),
                ),
                SizedBox(height: 30,),
                Text(
                      'Weekly Usage: ',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                Text(
                    'Trying to populate this correctly.',
                    style: TextStyle( color: Colors.indigo, fontSize: 16, letterSpacing: 1, ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
