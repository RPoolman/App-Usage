import 'package:flutter/material.dart';
import 'package:flutter_app/screens/register.dart';
import 'package:flutter_app/screens/signIn.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Register(),
    );
  }
}
