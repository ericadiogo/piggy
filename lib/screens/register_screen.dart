import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piggy/services/firebase_auth_methods.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget{
  static String routeName = '/signup-email-password';
  const RegisterScreen({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void registerUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context:context,);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You are registered!'),
      ),
    );
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => LoginScreen(),),);
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
        Text('Register',
            style: TextStyle(
              fontSize: 50,
              fontFamily: 'Lilita One',
            )
        ),
        SizedBox(height: 40,),
        Container(
          padding: EdgeInsets.fromLTRB(30,5,30,5),
          child:
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1.0,
                ),
              ),
              hintText: 'Name'
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.fromLTRB(30,5,30,5),
          child:
            TextField(controller: emailController,
              decoration: InputDecoration(
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
            TextField(controller: passwordController,
              obscureText: true,
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
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.fromLTRB(30,5,30,5),
          child:
            TextField(obscureText: true,
              decoration: InputDecoration(
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
        SizedBox(height: 40,),
        ElevatedButton(onPressed: registerUser,
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