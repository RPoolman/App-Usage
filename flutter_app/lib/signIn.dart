import 'package:flutter/material.dart';
import 'package:flutter_app/servicesAuth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        title: Text('Sign in to AppTracker'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: RaisedButton(
          child: Text('Sign in using an email'),
          onPressed: () async {
            // dynamic result = await _auth.signInEmailPass();
            // if (result == null){
            //   print('error on signing in.');
            // }else{
            //   print('signed in');
            //   print(result);
            // }
          },
        ),
      ),
    );
  }
}
