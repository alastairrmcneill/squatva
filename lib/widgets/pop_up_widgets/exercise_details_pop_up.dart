import 'package:flutter/material.dart';
import 'package:squatva/models/models.dart';
import 'package:squatva/services/exercise_service.dart';

class EditExercisePopUp extends StatelessWidget {
  final Exercise exercise;
  const EditExercisePopUp({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController(text: exercise.name);
    return AlertDialog(
      title: TextFormField(
        controller: textEditingController,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Exercise newExercise = exercise.copy(name: textEditingController.text);

            await ExerciseService.updateExercise(context, newExercise: newExercise);
            Navigator.of(context).pop();
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
