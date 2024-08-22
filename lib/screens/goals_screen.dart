import 'package:flutter/material.dart';
import 'package:piggy/screens/time_screen.dart';

import 'login_screen.dart';

class GoalsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen>{
  late String userName = '';
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFA3B2),
      body: Container(
        padding: EdgeInsets.all(40),
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[200],
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[300],
                      //backgroundImage: imageFile != null? FileImage(imageFile!) : null,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text('Hey, $userName!',
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: 'Lilita One',
                        color: Colors.white,
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: 40,),
            Text('New Piggy',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Lilita One',
              ),
            ),
            SizedBox(height: 80,),
            Text('Goal',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Lilita One',
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.fromLTRB(20,5,20,5),
              child:
              TextField(decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
                hintText: 'Name your goal!',
              ),
              ),
            ),
            SizedBox(height: 40,),
            Text('How much do you need to save?',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 30,),
            Slider(
              value: _currentSliderValue,
              max: 100000,
              divisions: 50000,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value){
                setState(() {
                  _currentSliderValue = value;
                });
              },
              activeColor: Colors.black,
              inactiveColor: Colors.grey[500],
            ),
            SizedBox(height: 20,),
            Text('\$ $_currentSliderValue',style: TextStyle(
                fontSize: 32,
              fontFamily: 'Lilita One',
              ),
            ),
            SizedBox(height: 40,),
            ElevatedButton(onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => TimeScreen(),),);
            },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
                fixedSize: MaterialStateProperty.all<Size>(Size(200.0, 60.0),),
              ),
              child: Text('Next',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),],
        ),
      ),
    );
  }
}