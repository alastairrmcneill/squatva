import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:squatva/models/models.dart';
import 'package:squatva/notifiers/notifiers.dart';
import 'package:squatva/services/services.dart';
import 'package:squatva/support/wrapper.dart';
import 'package:squatva/widgets/widgets.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FacebookAuth _facebookAuth = FacebookAuth.instance;

  // User stream
  static Stream<User?> get appUserStream {
    return _auth.authStateChanges();
  }

  // Current user id
  static String? get currentUserId {
    return _auth.currentUser?.uid;
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

      AppUser appUser = AppUser(
        uid: _auth.currentUser!.uid,
        name: name,
      );
      await UserDatabase.create(context, appUser: appUser);

      // TODO: Update notifiers
      // TODO: Better way to push to wrapper
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wrapper()), (_) => false);
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
  static Future signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential credential = await _auth.signInWithCredential(googleCredential);

      if (_auth.currentUser == null) return;

      AppUser appUser = AppUser(
        uid: _auth.currentUser!.uid,
        name: _auth.currentUser!.displayName!,
      );
      await UserDatabase.create(context, appUser: appUser);
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, message: error.message ?? 'There was an error with Google sign in.');
    }
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
          () async {
            await credential.user!.reload();
          },
        );
      }

      if (_auth.currentUser == null) return;

      AppUser appUser = AppUser(
        uid: _auth.currentUser!.uid,
        name: _auth.currentUser!.displayName!,
      );
      await UserDatabase.create(context, appUser: appUser);
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, message: error.message ?? "There was an error with Apple sign in.");
    } on SignInWithAppleAuthorizationException catch (error) {
      showErrorDialog(context, message: error.message);
    }
  }

  // Forgot password
  static Future forgotPassword(BuildContext context, {required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackBar(context, 'Sent password reset email.');
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, message: error.message ?? 'There was an error with this process.');
    }
  }

  // Sign out
  static Future signOut(BuildContext context) async {
    try {
      UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
      userNotifier.setCurrentUser = null;
      if (_googleSignIn.currentUser != null) {
        await _googleSignIn.disconnect();
      }
      await _auth.signOut();
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, message: error.message ?? "There was an error deleting your account");
    }
  }

  // Delete account
  static Future delete(BuildContext context) async {
    try {
      UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
      userNotifier.setCurrentUser = null;
      await UserDatabase.deleteUserWithUID(context, uid: _auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, message: error.message ?? "There was an error deleting your account");
    }
  }
}





  // Sign in with facebook
  // static Future signInWithFacebook(BuildContext context) async {
  //   try {
  //     LoginResult facebookLoginResult = await _facebookAuth.login(permissions: ['email']);

  //     // if (facebookLoginResult.accessToken == null) return;

  //     // OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);

  //     // UserCredential credential = await _auth.signInWithCredential(facebookAuthCredential);

  //     // print(credential.user.toString());
  //   } on FirebaseAuthException catch (error) {
  //     showErrorDialog(context, message: error.message ?? "There was an issue with facebook login");
  //   }
  // }