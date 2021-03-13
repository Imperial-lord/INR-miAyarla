import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorValidation {
  Future<bool> canDoctorGetApproved(User user) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('Doctors Database')
          .where('phoneNumber', isEqualTo: user.phoneNumber)
          .get();
      var docs = result.docs;
      return docs.length == 1;
    } catch (e) {
      throw e;
    }
  }
}
