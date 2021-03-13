import 'package:cloud_firestore/cloud_firestore.dart';

class UserTypeValidation {
  Future<bool> isUserRegDoctor(String uid) async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      var checkIsDoc =
          (await firestoreInstance.collection('Doctors').doc(uid).get()).exists;
      return checkIsDoc;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> isUserRegPatient(String uid) async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      var checkIsDoc =
      (await firestoreInstance.collection('Patients').doc(uid).get()).exists;
    return checkIsDoc;
    } catch (e) {
    throw e;
    }
  }
}
