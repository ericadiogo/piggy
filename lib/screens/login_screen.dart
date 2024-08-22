import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piggy/screens/profile_screen.dart';
import 'package:piggy/screens/register_screen.dart';

import '../services/firebase_auth_methods.dart';
import 'forgot_pass_screen.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance).loginEmail(
      email: emailController.text,
      password: passwordController.text,
      context:context,);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You are logged!'),
      ),
    );
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProfileScreen(),),);
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
            Text('Login',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Lilita One',
                )
            ),
            SizedBox(height: 60,),
            Container(
              padding: EdgeInsets.fromLTRB(30,5,30,5),
              child:
              TextField(controller:emailController,
                decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 3.0,
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
              TextField(controller: passwordController,
                decoration: InputDecoration(
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
            SizedBox(height: 80,),
            ElevatedButton(onPressed: loginUser,
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
              child: Text('Log In',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('I don\'t have an account. ', style: TextStyle(
                  fontSize: 16,
                ),
                ),
                new InkWell(
                  child: new Text('Register.', style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                  ),
                  onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen(),),
                  ),
                ),],
            ),
            new InkWell(
              child: new Text('Forgot password?', style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                ),
              ),
              onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ForgotPassScreen(),
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}