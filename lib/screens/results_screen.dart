import 'package:flutter/material.dart';



class ResultsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>{
  late String userName = '';
  late String goal = '';
  int _months = 0;

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
                  Column(
                    children: [
                      Text('Hey, $userName!',
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: 'Lilita One',
                          color: Colors.white,
                        ),
                      ),
                      Text('Hey, $userName!',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lilita One',
                          color: Colors.white,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40,),
            Text('$goal',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Lilita One',
              ),
            ),
            SizedBox(height: 80,),
            Text('Result',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Lilita One',
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Column(
                  children: [
                    Image.asset('assets/images/coin.png',width: 60),
                  ],
                ),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    Text('Find how much you need to save ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text('per period to achieve your goal.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Column(
                  children: [
                    Image.asset('assets/images/coingroup.png',width: 60),
                  ],
                ),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    Text('Progressive installments to help ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text('you achieve your goal faster.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 60,),
            ElevatedButton(onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => ResultsScreen(),),);
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