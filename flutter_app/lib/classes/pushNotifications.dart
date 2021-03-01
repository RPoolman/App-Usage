import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app/classes/deviceVars.dart';

class DeviceNotify {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void getUserPer() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
  void showUserPerGranted() {
    // print('User granted permission: ${settings.authorizationStatus}');
  }

}