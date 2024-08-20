import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
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