import 'package:firebase_messaging/firebase_messaging.dart';

class Notifications {
  void configureFCM(String id, String peerId) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print('$android and $notification');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }
}
