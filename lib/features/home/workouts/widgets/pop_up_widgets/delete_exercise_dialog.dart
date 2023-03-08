import 'package:flutter/material.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/services/services.dart';

class DeleteExercisePopUp extends StatelessWidget {
  final Exercise exercise;
  const DeleteExercisePopUp({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure you want to delete ${exercise.name}?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await ExerciseService.deleteExcercise(context, exercise: exercise);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Text('Delete'),
        ),
      ],
    );
  }
}
