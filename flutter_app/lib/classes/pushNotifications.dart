import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DeviceNotify {

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings;

  void getUserPer() async {
    settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    showUserPerGranted();
  }
  void showUserPerGranted() {
    print('User granted permission: ${settings.authorizationStatus}');
  }

}