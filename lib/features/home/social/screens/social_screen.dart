import 'package:flutter/material.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          '''Social feed \n\n Here you can follow your favourite athletes and friends to see what they are doing.''',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
