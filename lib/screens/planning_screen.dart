import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:piggy/screens/results_screen.dart';

import 'home_screen.dart';

class PlanningScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => ResultsScreen(),
      ));
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
            Text('Planning...',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Lilita One',
              )
            ),

          ],
        ),
      ),
    );
  }
}