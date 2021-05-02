import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/functions/general/createDownloadDirectory.dart';
import 'package:health_bag/functions/general/formatDateTime.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class LatestTestResults extends StatefulWidget {
  static String id = 'patient-latest-test-results';
  final String patientUID;

  LatestTestResults({@required this.patientUID});

  @override
  _LatestTestResultsState createState() =>
      _LatestTestResultsState(patientUID: patientUID);
}

String changeFileName(String name) {
  String newFileName = name;
  if (name.length > 15) newFileName = name.substring(0, 15);
  newFileName += ' ..';
  return newFileName;
}

class _LatestTestResultsState extends State<LatestTestResults> {
  void requestPermission() async {
    await Permission.storage.request().isGranted;
  }

  @override
  initState() {
    super.initState();
    requestPermission();
  }

  File testResult;
  String fileName;
  bool isLoading = false;

  final String patientUID;

  _LatestTestResultsState({@required this.patientUID});

  Future<String> downloadFile(String url, String fileName, String dir) async {
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = url;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      print(response);
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else
        filePath = 'Error code: ' + response.statusCode.toString();
    } catch (ex) {
      filePath = 'Can not fetch url';
    }

    return filePath;
  }

  Future getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png']);

    File file;
    PlatformFile resultFile = result.files.single;
    if (result != null) {
      file = File(resultFile.path);
    } else {
      print('User did not pick a file');
      return;
    }
    if (file != null) {
      setState(() {
        fileName = resultFile.name;
        testResult = file;
        isLoading = true;
      });
    }

    // make sure that the picture size does not exceed 2 MB
    if (testResult.lengthSync() / (1024 * 1024) > 2) {
      setState(() {
        testResult = null;
        isLoading = false;
        final bigPhotoSnackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: MyColors.black,
            content: MyFonts()
                .body('Please choose a file of size < 2 MB', MyColors.white));
        ScaffoldMessenger.of(context).showSnackBar(bigPhotoSnackBar);
      });
    } else
      uploadFile();
  }

  Future uploadFile() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    // ensures that each user occupies <= 2 MB in storage
    Reference ref =
        storage.ref().child("TestResult_" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(testResult);
    uploadTask.whenComplete(() async {
      var url = await ref.getDownloadURL();
      final firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance.collection('Prescription and Test Results').doc().set({
        'File Name': fileName,
        'Upload Time': DateTime.now(),
        'PatientUID': patientUID,
        'File Url': url,
      });
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColors.backgroundColor,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Prescription and Test Results')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container();
            else {
              List<QueryDocumentSnapshot> reportList = [];
              for (int i = 0; i < snapshot.data.docs.length; i++) {
                if (snapshot.data.docs[i].data()['PatientUID'] == patientUID)
                  reportList.add(snapshot.data.docs[i]);
              }
              return Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          MyFonts()
                              .heading1('Latest Test Results', MyColors.black),
                          Spacer(),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            padding: EdgeInsets.all(10),
                            onPressed: () {
                              getFile();
                            },
                            child: MyFonts().body('Upload', MyColors.white),
                            color: MyColors.blueLighter,
                          ),
                        ],
                      ),
                      MySpaces.vGapInBetween,
                      (reportList.length == 0)
                          ? MyFonts().body(
                              'No test result or prescription has been shared by you or your doctor. Click on the Upload button to share.',
                              MyColors.gray)
                          : Column(
                              children: [
                                for (int i = 0; i < reportList.length; i++)
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Card(
                                      elevation: 3,
                                      child: ListTile(
                                        onTap: () async {
                                          Directory appDir =
                                              await getExternalStorageDirectory();
                                          Directory directory = Directory(
                                              createDownloadDirectory(appDir));
                                          if (!await directory.exists()) {
                                            await directory.create(
                                                recursive: true);
                                          }
                                          if (await directory.exists()) {
                                            final downloadingPhotoSnackBar =
                                                SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    backgroundColor:
                                                        MyColors.black,
                                                    content: MyFonts().body(
                                                        'Opening ${reportList[i].data()['File Name']}',
                                                        MyColors.white));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                    downloadingPhotoSnackBar);
                                            String filePath =
                                                await (downloadFile(
                                                    reportList[i]
                                                        .data()['File Url'],
                                                    reportList[i]
                                                        .data()['File Name'],
                                                    directory.path));
                                            var _openResult = 'Unknown';
                                            final result =
                                                await OpenFile.open(filePath);
                                            setState(() {
                                              _openResult =
                                                  "type=${result.type}  message=${result.message}";
                                            });
                                          }
                                        },
                                        leading: Container(
                                            height: double.infinity,
                                            child:
                                                Icon(CupertinoIcons.doc_chart)),
                                        title: MyFonts().heading2(
                                            changeFileName(reportList[i]
                                                .data()['File Name']),
                                            MyColors.blueLighter),
                                        subtitle: MyFonts().subHeadline(
                                            formatDateTime(reportList[i]
                                                    .data()['Upload Time']
                                                    .toDate()
                                                    .toString()) +
                                                '\t\t' +
                                                DateFormat.jm().format(
                                                    reportList[i]
                                                        .data()['Upload Time']
                                                        .toDate()),
                                            MyColors.gray),
                                        trailing: Icon(
                                          Icons.download_rounded,
                                          color: MyColors.blueLighter,
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            )
                    ],
                  ),
                  isLoading?
                       Container(
                          height: (120 + reportList.length * 80).toDouble(),
                          child: Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    MyColors.blueLighter)),
                          ),
                          color: MyColors.backgroundColor.withOpacity(0.8),
                        )
                      : Container(),
                ],
              );
            }
          }),
    );
  }
}
