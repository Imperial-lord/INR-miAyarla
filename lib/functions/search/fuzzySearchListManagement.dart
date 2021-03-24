import 'package:flutter/cupertino.dart';
import 'package:fuzzy/fuzzy.dart';

class FuzzySearchListManagement {
  List<dynamic> patientList;

  FuzzySearchListManagement({@required this.patientList});

  List<String> convertDynamicToString(List<dynamic> documentData) {
    List<String> newList = [];
    for (int i = 0; i < documentData.length; i++) {
      newList
          .add('${documentData[i]['Name']}:${documentData[i]['PhoneNumber']}');
    }
    return newList;
  }

  List<dynamic> convertStringToDynamic(List<String> newList) {
    List<dynamic> documentData = [];
    for (int i = 0; i < newList.length; i++) {
      String number = newList[i].split(':')[1];
      for (int j = 0; j < patientList.length; j++) {
        if (patientList[j]['PhoneNumber'] == number) documentData.add(patientList[j]);
      }
    }
    return documentData;
  }

  List<dynamic> searchResults(String query) {
    List<String> stringPatientList = convertDynamicToString(patientList);

    if (query == '') return convertStringToDynamic(stringPatientList);

    var fuse = Fuzzy(stringPatientList,
        options: FuzzyOptions(
          findAllMatches: true,
          tokenize: true,
          threshold: 0.1,
        ));

    var result = fuse.search(query);
    List<String> stringResultList = [];
    result.forEach((element) {
      stringResultList.add(element.item);
    });

    List<dynamic> resultList = convertStringToDynamic(stringResultList);
    return resultList;
  }
}
