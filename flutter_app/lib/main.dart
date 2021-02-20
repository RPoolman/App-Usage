import 'package:flutter/material.dart';
import 'traffic.dart';

void main() => runApp(Apptracker());

class Apptracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Traffic(),
    );
  }
}
