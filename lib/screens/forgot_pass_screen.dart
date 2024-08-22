import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class ForgotPassScreen extends StatefulWidget{
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen>{
  final _emailController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim());
    } on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!),
        ),
      );
    }
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
            Padding(
                padding: EdgeInsets.all(20),
                child:
                  Text('Forgot Password?',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'Lilita One',
                      )
                  ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(28),
              child: Text('Please, type your registered email. We will send you a link to recover your password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
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
            SizedBox(height: 60,),
            ElevatedButton(onPressed: passwordReset,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
                fixedSize: MaterialStateProperty.all<Size>(Size(300.0, 60.0),),
              ),
              child: Text('Send Email Recovery',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}