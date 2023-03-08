import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/auth/screens/screens.dart';
import 'package:squatva/features/auth/widgets/widgets.dart';
import 'package:squatva/general/notifiers/notifiers.dart';
import 'package:squatva/general/services/services.dart';

class SocialSignInRow extends StatelessWidget {
  const SocialSignInRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SocialSignIn(
            backgroundColor: Colors.white,
            borderColor: Colors.blue,
            icon: const Icon(
              Icons.email_outlined,
              color: Colors.blue,
            ),
            function: () async {
              Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
            }),
        Platform.isIOS
            ? SocialSignIn(
                backgroundColor: Colors.black,
                borderColor: Colors.black,
                icon: Image.asset(
                  "assets/icons/apple_sign_in_icon.png",
                ),
                function: () async {
                  EnableNotifier enableNotifier = Provider.of<EnableNotifier>(context, listen: false);
                  if (!enableNotifier.appleSignInEnabled) return;
                  enableNotifier.setAppleSignInEnabled = false;

                  await AuthService.signInWithApple(context);
                  enableNotifier.setAppleSignInEnabled = true;
                })
            : const SizedBox(),
        SocialSignIn(
            backgroundColor: Colors.white,
            borderColor: Colors.black,
            icon: const Icon(
              FontAwesomeIcons.google,
              color: Colors.red,
            ),
            function: () async {
              EnableNotifier enableNotifier = Provider.of<EnableNotifier>(context, listen: false);
              if (!enableNotifier.googleSignInEnabled) return;
              enableNotifier.setGoogleSignInEnabled = false;

              await AuthService.signInWithGoogle(context);
              enableNotifier.setGoogleSignInEnabled = false;
            }),
      ],
    );
  }
}
