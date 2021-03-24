import 'package:cloud_firestore/cloud_firestore.dart';

class DocChosenValidation {
  Future<bool> hasPatientChosenDoctor(String uid) async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      var checkIsDocChosen =
          (await firestoreInstance.collection('Assigned Doctor').doc(uid).get())
              .exists;
      return checkIsDocChosen;
    } catch (e) {
      throw e;
    }
  }
}
