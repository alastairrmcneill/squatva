import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:squatva/screens/screens.dart';
import 'package:squatva/services/auth_service.dart';
import 'package:squatva/widgets/widgets.dart';

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
                  await AuthService.signInWithApple(context);
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
              await AuthService.signInWithGoogle(context);
            }),
      ],
    );
  }
}
