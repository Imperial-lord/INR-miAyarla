import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Notifications {
  void configureFCM(String patientUID) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print('$android and $notification');
      FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance
          .collection('Patient Chat Bubbles')
          .doc(patientUID)
          .set({'bubble': true});
      FirebaseFirestore firestoreInstance1 = FirebaseFirestore.instance;
      firestoreInstance1
          .collection('Doctor Chat Bubbles')
          .doc(patientUID)
          .set({'bubble': true});
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }
}
