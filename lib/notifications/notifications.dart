import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Notifications {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  void configureFCM(String patientUID) {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
        firestoreInstance
            .collection('Bubbles')
            .doc(patientUID)
            .set({'bubble': true});
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}
