import 'package:flutter/material.dart';

import 'login_screen.dart';

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
              fontSize: 50,
              fontFamily: 'Lilita One',
            )
        ),
        SizedBox(height: 20,),
        Container(
          padding: EdgeInsets.fromLTRB(30,5,30,5),
          child:
            TextField(decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
                hintText: 'Email',
              ),
            ),
        ),
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.fromLTRB(30,5,30,5),
          child:
            TextField(decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
                hintText: 'Password',
              ),
            ),
        ),
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.fromLTRB(30,5,30,5),
          child:
            TextField(decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
                hintText: 'Re-enter Password',
              ),
            ),
        ),
        SizedBox(height: 60,),
        ElevatedButton(onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen(),),);
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
          child: Text('Register',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
        SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('I have an account. ', style: TextStyle(
                fontSize: 16,
              ),
            ),
            new InkWell(
              child: new Text('Log in.', style: TextStyle(
                  fontSize: 16,
                color: Colors.blue,
                ),
              ),
              onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen(),),
              ),
            ),],
          ),],
        ),
      ),
    );
  }
}