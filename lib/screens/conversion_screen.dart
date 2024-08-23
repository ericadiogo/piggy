import 'package:flutter/material.dart';
import 'home_screen.dart';

class ConversionScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen>{
  late String userName = '';
  late String goal = '';
  int _months = 0;
  double _percent = 0;
  bool? isChecked = false;
  double _currentSliderValue = 0;
  double _goal = 0;

  void _changeMonths(int months){
    setState(() {
      _months +=months;
      if(_months <1) {
        _months = 0;
      }
    });
  }

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
                  Expanded(child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Hey, $userName!',
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: 'Lilita One',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Image.asset('assets/images/currency.png',width: 180),
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 4,
                    child:
                    Row(
                      children: [
                        Icon(
                          Icons.currency_exchange,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        SizedBox(width: 10,),
                        Text('Convert to:',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Lilita One',
                          ),
                        ),
                      ],
                    ),
                  ),
                             ],
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => ConversionScreen(),),);
            },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
                fixedSize: MaterialStateProperty.all<Size>(Size(150.0, 60.0),),
              ),
              child: Text('Conversion',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen(),),);
            },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
                fixedSize: MaterialStateProperty.all<Size>(Size(150.0, 60.0),),
              ),
              child: Text('Back',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}