import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Notifications {
  void configureFCM(String patientUID) {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        print('Message not null');
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print('$android and $notification');
      FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance
          .collection('Chat Bubbles')
          .doc(patientUID)
          .set({'bubble': true});
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }
}
