import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piggy/screens/launcher_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user == null){
        Future.delayed(Duration(seconds: 4),(){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => LauncherScreen(),
          ));
        });
      } else {
        Future.delayed(Duration(seconds: 4),(){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ));
        });
      }
    });
  }

  @override
  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFA3B2),
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/piggy_coins_glasses.png',width: 200),
            SizedBox(height: 40,),
            Text('PIGGY',
              style: TextStyle(
                fontSize: 80,
                fontFamily: 'Lilita One',
              )
            ),
            Text('Your Financial Planner',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 60,),
          ],
        ),
      ),
    );
  }
}