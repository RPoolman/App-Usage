import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/homePage.dart';

import 'deviceDataPage.dart';

import 'package:flutter_app/classes/deviceVars.dart';
import 'package:flutter_app/classes/dataAssesment.dart';

class StatScreen extends StatefulWidget {
  @override
  _StatScreenState createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  @override
  void initState() {
    UserUsageAssesment.getUserHours(GlobalData.totalAmountOnPhoneTodayHours);
    super.initState();
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
            IconButton(icon: Icon(Icons.person, color: Colors.indigo,), onPressed: () {
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
      SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        color: Colors.redAccent,
                        size: 50,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Daily Usage: ',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Your total amount spent on your phone today is:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    GlobalData.totalAmountOnPhoneToday,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'You fall in the bracket of: ',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    UserUsageAssesment.usageResult,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 22,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    UserUsageAssesment.resultDescription,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
