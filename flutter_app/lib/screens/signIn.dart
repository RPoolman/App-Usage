import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/classes/deviceExtrapolation.dart';
import 'package:flutter_app/classes/deviceVars.dart';

import 'package:flutter_app/screens/homePage.dart';

import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/servicesAuth.dart';

import 'package:flutter_app/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function view;
  SignIn({ this.view });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        title: Text('Sign in to AppTracker'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              widget.view();
            },
            icon: Icon(Icons.person, color: Colors.white,),
            label: Text('Register', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Text('Enter your email below:',style: TextStyle(fontSize: 20),),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your email here',
                ),
                validator: (val) => val.isEmpty ? 'Please enter a valid email...' : null,
                onChanged: (value){
                  setState(() { email = value;});
                },
              ),
              SizedBox(height: 20.0),
              Text('Enter your password below:',style: TextStyle(fontSize: 20),),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your password here',
                ),
                validator: (val) => val.length < 6 ? 'Please enter a password that is 6 characters long' : null,
                obscureText: true,
                onChanged: (value){
                  setState(() {password = value;});
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.signMeInEmailPassword(email, password);
                      if(result == null) {
                        setState(() {
                          error = 'Could not sign you in with those credentials.';
                          loading = false;
                        });
                      } else {
                        loading = false;
                        await DeviceData.getUsageStats();
                        // return new StreamBuilder<DocumentSnapshot>(
                        //   stream: FirebaseFirestore.instance
                        //       .collection('users')
                        //       .doc(GlobalData.loggedInUserID)
                        //       .snapshots(),
                        //   builder: (context, snapshot) {
                        //   if (!snapshot.hasData) {
                        //     return new Text("Loading");
                        //   } else {
                        //     Map<String, dynamic> documentFields = snapshot.data.data();
                        //     GlobalData.userTrackedName =  documentFields["username"];
                        //     GlobalData.userTrackingName = documentFields["usertrackname"];
                        //     return null;
                        //   }
                        // });
                        }
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LandingPage()));
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
    );
  }
}
