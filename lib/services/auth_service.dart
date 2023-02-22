import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/notifiers/notifiers.dart';
import 'package:squatva/widgets/widgets.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // User stream
  static Stream<User?> get appUserStream {
    return _auth.authStateChanges();
  }

  // Register with email
  static Future registerWithEmail(BuildContext context, {required String email, required String password, required String name}) async {
    try {
      // Register in Firebase Auth
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user == null) return;

      // Update display name
      credential.user!
          .updateDisplayName(
            name,
          )
          .whenComplete(
            () => credential.user!.reload(),
          );

      // TODO: Create user in database and update notifiers

    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, message: error.message ?? 'There was an error with authorisation.');
    }
  }

  // Sign in with email
  static Future signInWithEmail(BuildContext context, {required String email, required String password}) async {
    try {
      // Login to firebase
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      // TODO: read user from database and update notifiers
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, message: error.message ?? "There has been an error logging in.");
    }
  }

  // Sign in with google

  // Sign in with apple

  // Forgot password
  static Future forgotPassword(BuildContext context, {required String email}) async {
    EnableNotifier enableNotifier = Provider.of<EnableNotifier>(context, listen: false);
    if (!enableNotifier.passwordRecoveryEnabled) return;
    enableNotifier.setPasswordRecoveryEnabled = false;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackBar(context, 'Sent password reset email.');
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, message: error.message ?? 'There was an error with this process.');
    }
    enableNotifier.setPasswordRecoveryEnabled = true;
  }

  // Sign out
  static Future signOut() async {
    await _auth.signOut();
  }

  // Delete account
  static Future delete() async {
    await _auth.currentUser?.delete();
  }
}
