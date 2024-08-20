import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{
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
        Text('Register',
            style: TextStyle(
              fontSize: 60,
              fontFamily: 'Lilita One',
            )
        ),
        Text('Your Financial Planner',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 80,),
        ElevatedButton(onPressed: (){},
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
            fixedSize: MaterialStateProperty.all<Size>(Size(200.0, 60.0),),
          ),
          child: Text('Log In',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
        SizedBox(height: 15,),
        new InkWell(
          child: new Text('Register Here', style: TextStyle(
            fontSize: 20,
          ),
          ),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()),
          ),
        ),
            ],
        ),
      ),
    );
  }
}