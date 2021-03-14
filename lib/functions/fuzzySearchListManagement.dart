import 'package:fuzzy/fuzzy.dart';

class FuzzySearchListManagement {
  List<String> patientList = [
    'Prashant Khatri:+91-9876543210',
    'Kartikeya Singh:+91-8875412376',
    'Siddhartha Jain:+91-9542837352',
    'Mohammed Humam Khan:+91-9812343543',
    'Dhawal Badi:+91-9721342344',
    'AB Satyaprakash:+91-9431234568',
  ];

  List<String> searchResults(String query) {
    if (query == '') return patientList;

    var fuse = Fuzzy(patientList,
        options: FuzzyOptions(
          findAllMatches: true,
          tokenize: true,
          threshold: 0.1,
        ));

    var result = fuse.search(query);
    List<String> resultList = [];
    result.forEach((element) {
      resultList.add(element.item);
    });
    return resultList;
  }
}
