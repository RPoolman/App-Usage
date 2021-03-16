import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/screens/homePage.dart';

import 'package:flutter_app/services/servicesAuth.dart';
import 'package:flutter_app/services/database.dart';

import 'package:flutter_app/shared/loading.dart';
import 'package:flutter_app/classes/deviceVars.dart';
import 'package:flutter_app/classes/deviceExtrapolation.dart';

class Register extends StatefulWidget {

  final Function view;
  Register({ this.view });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  static void getStats() async {
    await DeviceData.getUsageStats();
  }

  final AuthService _auth = new AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String mainEmail = '';
  String password = '';
  String userName = '';
  String userParent = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('Register for AppTracker',style: TextStyle(color: Colors.indigo),),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              widget.view();
            },
            icon: Icon(Icons.person, color: Colors.indigo,),
            label: Text('Sign In', style: TextStyle(color: Colors.indigo)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text('Enter your name below:',style: TextStyle(fontSize: 20, color: Colors.white),),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white70),
                    hintText: 'Enter the parents name here',
                    fillColor: Colors.white,
                  ),
                  validator: (val) => val.isEmpty ? 'A name is needed' : null,
                  onChanged: (value){
                    setState(() {
                      for(int x = 0; x < value.length; x++) {
                        if(x == 0) {
                          GlobalData.userTrackingName = value[x].toUpperCase().toString();
                        } else { GlobalData.userTrackingName += value[x].toLowerCase().toString(); }
                      }
                    });
                  },
                ),
                SizedBox(height: 20.0),
                Text('Enter your child\'s name below:',style: TextStyle(fontSize: 20, color: Colors.white),),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white70),
                    hintText: 'Enter the child\'s name here',
                    fillColor: Colors.white,
                  ),
                  validator: (val) => val.isEmpty ? 'A name is needed' : null,
                  onChanged: (value){
                    setState(() {
                      for(int x = 0; x < value.length; x++) {
                        if(x == 0) {
                          GlobalData.userTrackedName = value[x].toUpperCase().toString();
                        } else { GlobalData.userTrackedName += value[x].toLowerCase().toString(); }
                      }
                    });
                  },
                ),
                SizedBox(height: 20.0),
                Text('Enter your email below to register:',style: TextStyle(fontSize: 20, color: Colors.white),),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white70),
                    hintText: 'Enter your email here',
                    fillColor: Colors.white,
                  ),
                  validator: (val){
                                    Pattern pattern =
                                        r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+";
                                    RegExp regExp = new RegExp(pattern);
                                      if (val.isEmpty) {
                                        return 'Please enter an email.';
                                      } else if (!regExp.hasMatch(val)) {
                                        return 'The information you entered is not valid. Please add your email and try again.';
                                      } else {
                                        return null;
                                      }
                                  },
                  onChanged: (value){
                    setState(() { mainEmail = value;});
                  },
                ),
                SizedBox(height: 20.0),
                Text('Enter your password below:',style: TextStyle(fontSize: 20, color: Colors.white),),
                TextFormField(
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white70),
                    hintText: 'Enter your password here',
                    fillColor: Colors.white,
                  ),
                  validator: (val) => val.length < 6 ? 'Please enter a password that is 6 characters long' : null,
                  obscureText: true,
                  onChanged: (value){
                    setState(() { password = value;});
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.indigo,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth.registerMeWithEmailPassword(mainEmail, password);
                        if(result == null) {
                          setState(() {
                            error = 'Please supply a valid email.';
                            loading = false;
                          });
                        } else {
                          setState(() {
                            loading = false;
                          });
                          await getStats();
                          List<String> times = GlobalData.applicationList;
                          List<String> apps = GlobalData.applicationNameList;
                          List<String> apptimes = [];
                          for(int i = 0; i < times.length; i++) {
                            apptimes.add(apps[i] + " -> " + times[i]);
                          }
                          DatabaseService(uid: GlobalData.loggedInUserID).updateUserData(GlobalData.userTrackingName, GlobalData.userTrackedName, apptimes);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LandingPage()));
                        }
                      }
                    }
                ),
                SizedBox(height: 12.0,),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
