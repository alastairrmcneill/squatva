import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:squatva/notifiers/notifiers.dart';
import 'package:squatva/widgets/widgets.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // User stream
  static Stream<User?> get appUserStream {
    return _auth.authStateChanges();
  }

  // Register with email
  static Future registerWithEmail(BuildContext context, {required String email, required String password, required String name}) async {
    EnableNotifier enableNotifier = Provider.of<EnableNotifier>(context, listen: false);
    if (!enableNotifier.registerEnabled) return;
    enableNotifier.setRegisterEnabled = false;
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
    enableNotifier.setRegisterEnabled = true;
  }

  // Sign in with email
  static Future signInWithEmail(BuildContext context, {required String email, required String password}) async {
    EnableNotifier enableNotifier = Provider.of<EnableNotifier>(context, listen: false);
    if (!enableNotifier.signInEnabled) return;
    enableNotifier.setSignInEnabled = false;
    try {
      // Login to firebase
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      // TODO: read user from database and update notifiers
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, message: error.message ?? "There has been an error logging in.");
    }
    enableNotifier.setSignInEnabled = true;
  }

  // Sign in with google
  static Future signInWithGoogle(BuildContext context) async {
    EnableNotifier enableNotifier = Provider.of<EnableNotifier>(context, listen: false);
    if (!enableNotifier.googleSignInEnabled) return;
    enableNotifier.setGoogleSignInEnabled = false;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential credential = await _auth.signInWithCredential(googleCredential);

      // TODO: Create user in database and update notifiers

    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, message: error.message ?? 'There was an error with Google sign in.');
    }
    enableNotifier.setGoogleSignInEnabled = true;
  }

  // Sign in with apple
  static Future signInWithApple(BuildContext context) async {
    try {
      final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
      OAuthCredential appleCredential = oAuthProvider.credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
      );

      UserCredential credential = await _auth.signInWithCredential(appleCredential);

      if (credential.user!.displayName == null) {
        await credential.user!
            .updateDisplayName(
              "${appleIdCredential.givenName ?? ""} ${appleIdCredential.familyName ?? ""}",
            )
            .whenComplete(
              () => credential.user!.reload(),
            );
      }

      // TODO: Create user and update notifiers

    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, message: error.message ?? "There was an error with Apple sign in.");
    } on SignInWithAppleAuthorizationException catch (error) {
      showErrorDialog(context, message: error.message);
    }
  }

  // Sign in with facebook

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
