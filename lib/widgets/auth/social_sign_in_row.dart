import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            borderColor: Colors.black,
            icon: const Icon(
              FontAwesomeIcons.google,
              color: Colors.red,
            ),
            function: () async {
              print('Google');
            }),
        Platform.isIOS
            ? SocialSignIn(
                backgroundColor: Colors.black,
                borderColor: Colors.black,
                icon: Image.asset(
                  "assets/icons/apple_sign_in_icon.png",
                ),
                function: () async {
                  print('Apple');
                })
            : const SizedBox(),
        SocialSignIn(
            backgroundColor: Colors.blue,
            borderColor: Colors.blue,
            icon: const Icon(
              FontAwesomeIcons.facebookF,
              color: Colors.white,
            ),
            function: () async {
              print('Facebook');
            }),
      ],
    );
  }
}
