import 'package:cloud_firestore/cloud_firestore.dart';

class AdditionalPatientCollections {
  void createAdditionalCollections(String uid) {
    // add additional collections for patient to use later
    /*
    1. Important Dates (LastVisit, NextVisit)
    2. Prescription and Test Results (Photo)
    3. Notifications (Message)
    4. Medicines (Name, Timing)
    5. DoctorNotes (Note)
    */
    FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance
        .collection('Important Dates')
        .doc(uid)
        .set({'LastVisit': '', 'NextVisit': ''});
    firestoreInstance.collection('Prescription and Test Results').doc(uid).set({
      'Photo': [],
    });
    firestoreInstance.collection('Medicines').doc(uid).set({'Medicine': []});
    firestoreInstance.collection('Doctor Notes').doc(uid).set({
      'Note': [],
    });
    firestoreInstance.collection('Patient Chat Bubbles').doc(uid).set({
      'bubble': false,
    });
    firestoreInstance.collection('Doctor Chat Bubbles').doc(uid).set({
      'bubble': false,
    });
  }
}
