import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app/services/servicesAuth.dart';
import 'package:flutter_app/services/database.dart';

import 'package:flutter_app/screens/signIn.dart';
import 'package:flutter_app/screens/deviceDataPage.dart';
import 'package:flutter_app/screens/analiticsPage.dart';

import 'package:flutter_app/classes/deviceVars.dart';
import 'package:flutter_app/classes/dataChart.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}
class _LandingPageState extends State<LandingPage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userShot,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('App Tracker',style: TextStyle(color: Colors.white,letterSpacing: 0.8, fontSize: 28,)),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signMeOut();
                  if(_auth.signMeOut() != null) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> SignIn()), (route) => false);
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn()));
                  }
                },
                icon: Icon(Icons.person, color: Colors.white,),
                label: Text('Logout', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: Icon(Icons.home, color: Colors.indigo,), onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LandingPage()),
                        (route) => false
                );},
              ),
              SizedBox(width: 20,),
              IconButton(icon: Icon(Icons.list_alt), onPressed: () {
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
        padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tracking: ',
                  style: TextStyle(color: Colors.blueAccent,letterSpacing: 2.0,fontSize: 18.0,),
                ),
                SizedBox(height: 4),
                Text(
                  GlobalData.userTrackedName,
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
                  GlobalData.userTrackingName,
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
                  'Most Used Apps',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 22,
                    letterSpacing: 1,
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Text(
                          GlobalData.app1Name,
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                        Row(
                          children: [
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
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          GlobalData.app2Name,
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                        Row(
                          children: [
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
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          GlobalData.app3Name,
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                        Row(
                          children: [
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    height:300,
                    child: PointsLineChart(
                      PointsLineChart.createSampleData(), animate: false,
                    ),
                  ),
                ),],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
