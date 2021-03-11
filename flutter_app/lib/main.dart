import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/shared/loading.dart';
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
  bool loading = false;
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
    loading = true;
    if(_error) {
      loading = false;
    }
    if (!_initialized) {
      loading = true;
    }
    return StreamProvider<UserApptracker>.value(
      // value: AuthService().signedInUser,
      child: MaterialApp(
        home: _initialized ? Traffic() : loading ? Loading() : Traffic(),
      ),
    );
  }
}

