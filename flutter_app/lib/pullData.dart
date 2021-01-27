import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Row(
    children: <Widget>[
      RaisedButton(
        onPressed: () =>  AppSettings.openLocationSettings(),
        child: Text('Open Location Settings'),
      ),
    ],
  );
}
