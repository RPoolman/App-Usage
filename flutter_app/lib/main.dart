import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/services/servicesAuth.dart';
import 'package:provider/provider.dart';
import 'services/traffic.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Apptracker());
}

class Apptracker extends StatefulWidget {
  _ApptrackerState createState() => _ApptrackerState();
}

class _ApptrackerState extends State<Apptracker> {
  bool _initialized = false;
  bool _error = false;
  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      setState(() {
        _error = true;
      });
    }
  }
  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    if(_error) {
      print('was nice knowing you');
    }
    if (!_initialized) {
      print('waiting...');
    }
    return StreamProvider<UserApptracker>.value(
      // value: AuthService().signedInUser,
      child: MaterialApp(
        home: Traffic(),
      ),
    );
  }
}

