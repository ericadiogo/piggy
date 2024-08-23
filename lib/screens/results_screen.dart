import 'package:flutter/material.dart';

import 'conversion_screen.dart';
import 'home_screen.dart';

class ResultsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>{
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hey, $userName!',
                          style: TextStyle(
                            fontSize: 36,
                            fontFamily: 'Lilita One',
                            color: Colors.white,
                          ),
                        ),
                        Text('You reached less than ($_percent)% of your Piggy.',
                          style: TextStyle(
                            fontSize: 16,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children:[
                      Text('Goal',
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Lilita One',
                        ),
                      ),
                      Text('\$ $_goal',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lilita One',
                        ),
                      ),
                    ],
                  )
                ),
                SizedBox(width: 5,),
                Expanded(
                  flex: 6,
                  child: Slider(
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
                ),
                Expanded(
                  flex: 2,
                  child: Text('\$ $_currentSliderValue',style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Lilita One',
                  ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            Row(

              children: [
                Expanded(child:
                  Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: Colors.black,
                            tristate: true,
                            onChanged: (newBool){
                              setState(() {
                                isChecked = newBool;
                              });
                            },
                          ),
                          Text('\$ 50.00',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: Colors.black,
                            tristate: true,
                            onChanged: (newBool){
                              setState(() {
                                isChecked = newBool;
                              });
                            },
                          ),
                          Text('\$ 100.00',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: Colors.black,
                            tristate: true,
                            onChanged: (newBool){
                              setState(() {
                                isChecked = newBool;
                              });
                            },
                          ),
                          Text('\$ 200.00',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: Colors.black,
                            tristate: true,
                            onChanged: (newBool){
                              setState(() {
                                isChecked = newBool;
                              });
                            },
                          ),
                          Text('\$ 400.00',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: Colors.black,
                            tristate: true,
                            onChanged: (newBool){
                              setState(() {
                                isChecked = newBool;
                              });
                            },
                          ),
                          Text('\$ 800.00',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: Colors.black,
                            tristate: true,
                            onChanged: (newBool){
                              setState(() {
                                isChecked = newBool;
                              });
                            },
                          ),
                          Text('\$ 1000.00',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: Colors.black,
                            tristate: true,
                            onChanged: (newBool){
                              setState(() {
                                isChecked = newBool;
                              });
                            },
                          ),
                          Text('\$ 1200.00',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: Colors.black,
                            tristate: true,
                            onChanged: (newBool){
                              setState(() {
                                isChecked = newBool;
                              });
                            },
                          ),
                          Text('\$ 1500.00',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          ),
                        ],
                      ),
                    ],
                  )
                ),
                SizedBox(width: 10,),
                Expanded(child:
                Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          activeColor: Colors.black,
                          tristate: true,
                          onChanged: (newBool){
                            setState(() {
                              isChecked = newBool;
                            });
                          },
                        ),
                        Text('\$ 5.00',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          activeColor: Colors.black,
                          tristate: true,
                          onChanged: (newBool){
                            setState(() {
                              isChecked = newBool;
                            });
                          },
                        ),
                        Text('\$ 10.00',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          activeColor: Colors.black,
                          tristate: true,
                          onChanged: (newBool){
                            setState(() {
                              isChecked = newBool;
                            });
                          },
                        ),
                        Text('\$ 15.00',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          activeColor: Colors.black,
                          tristate: true,
                          onChanged: (newBool){
                            setState(() {
                              isChecked = newBool;
                            });
                          },
                        ),
                        Text('\$ 20.00',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          activeColor: Colors.black,
                          tristate: true,
                          onChanged: (newBool){
                            setState(() {
                              isChecked = newBool;
                            });
                          },
                        ),
                        Text('\$ 25.00',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          activeColor: Colors.black,
                          tristate: true,
                          onChanged: (newBool){
                            setState(() {
                              isChecked = newBool;
                            });
                          },
                        ),
                        Text('\$ 30.00',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          activeColor: Colors.black,
                          tristate: true,
                          onChanged: (newBool){
                            setState(() {
                              isChecked = newBool;
                            });
                          },
                        ),
                        Text('\$ 35.00',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          activeColor: Colors.black,
                          tristate: true,
                          onChanged: (newBool){
                            setState(() {
                              isChecked = newBool;
                            });
                          },
                        ),
                        Text('\$ 40.00',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        ),
                      ],
                    ),
                  ],
                )
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                SizedBox(width: 10,),
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
          ],
        ),
      ),
    );
  }
}