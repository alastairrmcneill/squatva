import 'package:flutter/material.dart';
import 'package:squatva/features/home/record/screens/log_workout_screen.dart';

class CurrentWorkoutOverlay extends StatelessWidget {
  const CurrentWorkoutOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LogWorkoutScreen())),
      child: Container(
        color: Colors.grey[300],
        height: 100,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Workout in progress. Click to resume'),
          ),
        ),
      ),
    );
  }
}
