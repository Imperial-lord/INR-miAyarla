import 'package:flutter/material.dart';
import 'package:health_bag/pages/common/welcome.dart';
import 'package:health_bag/widgets/backgrounds/backgrounds.dart';
import 'package:health_bag/widgets/backgrounds/firstBackground.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Bag',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Welcome(),
    );
  }
}
