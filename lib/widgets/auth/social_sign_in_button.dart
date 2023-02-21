import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SocialSignIn extends StatelessWidget {
  final Color color;
  final Icon icon;
  final AsyncCallback function;
  const SocialSignIn({super.key, required this.color, required this.icon, required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await function;
      },
      child: Container(
        decoration: BoxDecoration(color: color),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
