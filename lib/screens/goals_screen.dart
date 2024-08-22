import 'package:flutter/material.dart';

import 'login_screen.dart';

class GoalsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen>{
  late String userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFA3B2),
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text('Hey, $userName!',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Lilita One',
                        color: Colors.white,
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: 80,),
            Text('My Monthly Income',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.fromLTRB(60,5,60,5),
              child:
              TextField(decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
                hintText: '\$',
              ),
              ),
            ),
            SizedBox(height: 30,),
            Text('My Monthly Fixed Expenses',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.fromLTRB(60,5,60,5),
              child:
              TextField(decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
                hintText: '\$',
              ),
              ),
            ),
            SizedBox(height: 30,),
            Text('Monthly Variable Expenses (Approximately)',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.fromLTRB(60,5,60,5),
              child:
              TextField(decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
                hintText: '\$',
              ),
              ),
            ),

            SizedBox(height: 60,),
            ElevatedButton(onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => GoalsScreen(),),);
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
              child: Text('Finish',
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