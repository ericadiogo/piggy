import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      //await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      SnackBar(content: Text(e.message!),);
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try{
      _auth.currentUser!.sendEmailVerification();
      SnackBar(content: Text('Email verification sent.'),);
    } on FirebaseAuthException catch(e) {
      SnackBar(content: Text(e.message!),);
    }
  }
}