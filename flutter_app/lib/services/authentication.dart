import 'package:flutter/material.dart';
import 'package:flutter_app/screens/register.dart';
import 'package:flutter_app/screens/signIn.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool userSignIn = true;
  void toggleView() {
    setState(() => userSignIn = !userSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(userSignIn) {
      return SignIn(view: toggleView);
    } else {
      return Register(view: toggleView);
    }
  }
}
