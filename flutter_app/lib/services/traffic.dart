import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/homePage.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:provider/provider.dart';

class Traffic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final currentUser = Provider.of<User>(context);
    return LandingPage();
    if(currentUser == null) {
      return Authentication();
    } else {
      return LandingPage();
    }
  }
}
