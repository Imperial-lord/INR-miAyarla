import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/pages/common/aboutApp.dart';
import 'package:health_bag/pages/common/auth/signin.dart';
import 'package:health_bag/pages/common/splash.dart';
import 'package:health_bag/pages/common/userType.dart';
import 'package:health_bag/pages/common/welcome.dart';
import 'package:health_bag/pages/doctor/addMoreDoctors.dart';
import 'package:health_bag/pages/doctor/doctorApproved.dart';
import 'package:health_bag/pages/doctor/doctorHome.dart';
import 'package:health_bag/pages/doctor/doctorManagement.dart';
import 'package:health_bag/pages/doctor/doctorPatientInterface.dart';
import 'package:health_bag/pages/doctor/doctorProfile.dart';
import 'package:health_bag/pages/doctor/doctorReg.dart';
import 'package:health_bag/pages/doctor/doctorRejected.dart';
import 'package:health_bag/pages/doctor/doctorSendNotifications.dart';
import 'package:health_bag/pages/doctor/doctorUploadPhoto.dart';
import 'package:health_bag/pages/doctor/patientmonitor/monitorPatientHealth.dart';
import 'package:health_bag/pages/patients/patientEditProfile.dart';
import 'package:health_bag/pages/patients/patientHome.dart';
import 'package:health_bag/pages/patients/patientManagement.dart';
import 'package:health_bag/pages/patients/patientNotifications.dart';
import 'package:health_bag/pages/patients/patientProfile.dart';
import 'package:health_bag/pages/patients/patientReg.dart';
import 'package:health_bag/pages/patients/patientSelectDoctor.dart';
import 'package:health_bag/pages/patients/patientUploadPhoto.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('Something has gone wrong!');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              Provider<LoginStore>(
                create: (_) => LoginStore(),
              ),
            ],
            child: MaterialApp(
              supportedLocales: [
                Locale('en'),
              ],
              localizationsDelegates: [
                CountryLocalizations.delegate,
              ],
              title: 'INR-miAyarla',
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              home: Splash(),
              routes: {
                Splash.id: (context) => Splash(),
                UserType.id: (context) => UserType(),
                Welcome.id: (context) => Welcome(),
                SignIn.id: (context) => SignIn(),
                AboutApp.id: (context) => AboutApp(),
                PatientEditProfile.id: (context) => PatientEditProfile(null),
                PatientReg.id: (content) => PatientReg(),
                PatientHome.id: (context) => PatientHome(),
                PatientNotifications.id: (context) => PatientNotifications(),
                PatientProfile.id: (context) => PatientProfile(),
                PatientManagement.id: (context) => PatientManagement(),
                PatientUploadPhoto.id: (context) => PatientUploadPhoto(),
                PatientSelectDoctor.id: (context) => PatientSelectDoctor(),
                DoctorApproved.id: (context) => DoctorApproved(),
                DoctorRejected.id: (context) => DoctorRejected(),
                AddMoreDoctors.id: (context) => AddMoreDoctors(),
                DoctorHome.id: (context) => DoctorHome(
                      doctorUID: null,
                    ),
                DoctorProfile.id: (context) => DoctorProfile(),
                DoctorManagement.id: (context) => DoctorManagement(),
                DoctorReg.id: (context) => DoctorReg(),
                DoctorUploadPhoto.id: (context) => DoctorUploadPhoto(),
                DoctorPatientInterface.id: (context) => DoctorPatientInterface(
                      patientNumber: null,
                    ),
                MonitorPatientHealth.id: (context) => MonitorPatientHealth(
                      patientUID: null,
                    ),
                DoctorSendNotifications.id: (context) =>
                    DoctorSendNotifications(patientUID: null),
              },
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          title: 'INR-miAyarla',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          home: Material(
            color: MyColors.blue,
          ),
        );
      },
    );
  }
}
