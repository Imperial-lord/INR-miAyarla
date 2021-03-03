import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/pages/common/auth/signin.dart';
import 'package:health_bag/pages/common/home_page.dart';
import 'package:health_bag/pages/common/splash.dart';
import 'package:health_bag/pages/common/userType.dart';
import 'package:health_bag/pages/common/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:health_bag/widgets/backgrounds/secondBackground.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:health_bag/stores/login_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
              title: 'Health Bag',
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              home: Splash(),
              routes: {
                Splash.id: (context) => Splash(),
                UserType.id: (context) => UserType(),
                Welcome.id: (context) => Welcome(),
                SignIn.id: (context) => SignIn(),
                HomePage.id: (context) => HomePage(),
              },
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          title: 'Health Bag',
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
