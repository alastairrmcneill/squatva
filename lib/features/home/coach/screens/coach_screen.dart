import 'package:flutter/material.dart';

class CoachScreen extends StatelessWidget {
  const CoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          '''Coaching Station\n\n Where you build workout programs and share with your athletes. Possibly a paid model in the future. ''',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
