import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/homePage.dart';
import 'package:flutter_app/services/servicesAuth.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter_app/classes/deviceExtrapolation.dart';

class Register extends StatefulWidget {

  final Function view;
  Register({ this.view });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = new AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String mainEmail = '';
  String password = '';
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
              children: <Widget>[
                SizedBox(height: 20.0),
                Text('Enter your email below to register:',style: TextStyle(fontSize: 20),),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email here',
                  ),
                  validator: (val) => val.isEmpty ? 'Please enter a valid email...' : null,
                  onChanged: (value){
                    setState(() { mainEmail = value;});
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
                          setState(() => loading = false);
                          DeviceData.getUsageStats();
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
