import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:provider/provider.dart';
import 'package:health_bag/stores/login_store.dart';

class HomePage extends StatefulWidget {
  static String id = 'home-page';
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  loginStore.signOut(context);
                },
                color: MyColors.blue,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14))
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Sign Out', style: TextStyle(color: Colors.white),),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: MyColors.blueLightest,
                        ),
                        child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
