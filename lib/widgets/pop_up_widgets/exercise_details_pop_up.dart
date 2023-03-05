import 'package:flutter/material.dart';
import 'package:squatva/models/models.dart';

class ExerciseDetailsPopUp extends StatelessWidget {
  final Exercise exercise;
  const ExerciseDetailsPopUp({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(exercise.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(exercise.note ?? ""),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    );
  }
}
