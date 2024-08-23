import 'package:flutter/material.dart';
import 'package:piggy/screens/planning_screen.dart';
import 'package:piggy/screens/results_screen.dart';
import 'package:piggy/screens/time_screen.dart';

import 'login_screen.dart';

class NewPiggyScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NewPiggyScreenState();
}

class _NewPiggyScreenState extends State<NewPiggyScreen>{
  late String userName = '';
  double _currentSliderValue = 0;
  int _months = 0;
  bool? isChecked = false;

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
      body: SingleChildScrollView(
        child:       Container(
          padding: EdgeInsets.all(40),
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
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
              SizedBox(height: 40,),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Goal',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'Lilita One',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
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
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('How much do you need to save?',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'Lilita One',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
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
                fontSize: 28,
                fontFamily: 'Lilita One',
              ),
              ),
              SizedBox(height: 20,),
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
                              Icons.access_time,
                              color: Colors.black,
                              size: 20.0,
                            ),
                            SizedBox(width: 10,),
                            Text('Time',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 21,
                                fontFamily: 'Lilita One',
                              ),
                           ),
                          ],
                        ),
                    ),
                    Expanded(
                      child: TextField(decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1.0,
                          ),
                        ),
                        hintText: '$_months',
                      ),
                      ),
                    ),
                  ],
                ),

              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Means',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'Lilita One',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 1,
                      child: Checkbox(
                        value: isChecked,
                        activeColor: Colors.black,
                        tristate: true,
                        onChanged: (newBool){
                          setState(() {
                            isChecked = newBool;
                          });
                        },
                      ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.asset('assets/images/coin.png',width: 15),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 7,
                    child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Fixed Installments',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 2,),
                          Text('Find how much you need to save per period to achieve your goal.',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text('',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Checkbox(
                      value: isChecked,
                      activeColor: Colors.black,
                      tristate: true,
                      onChanged: (newBool){
                        setState(() {
                          isChecked = newBool;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.asset('assets/images/coingroup.png',width: 15),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 7,
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Progressive Installments',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 2,),
                        Text('Progressive installments to help you achieve your goal faster, with a little challenge.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text('',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlanningScreen(),),);
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
                child: Text('Create!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),],
          ),
        ),
      ),
    );
  }
}