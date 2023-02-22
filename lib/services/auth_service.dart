import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // User stream
  static Stream<User?> get appUserStream {
    return _auth.authStateChanges();
  }

  // Register with email
  static Future registerWithEmail(BuildContext context, {required String email, required String password, required String name}) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      print(error.message);
    }
  }

  // Sign in with email
  static Future signInWithEmail(BuildContext context, {required String email, required String password}) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      print(error.message);
    }
  }

  //Sign in with google

  // Sign in with apple

  // Forgot password

  // Sign out
  static Future signOut() async {
    await _auth.signOut();
  }
}
