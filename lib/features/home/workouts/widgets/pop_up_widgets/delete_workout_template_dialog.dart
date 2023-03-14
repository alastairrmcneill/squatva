// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/services/services.dart';

class DeleteWorkoutTemplatePopUp extends StatelessWidget {
  final WorkoutTemplate workoutTemplate;
  const DeleteWorkoutTemplatePopUp({
    Key? key,
    required this.workoutTemplate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure you want to delete ${workoutTemplate.name}? This will not impact any logged workouts.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await WorkoutService.deleteWorkoutTemplate(context, workoutTemplate: workoutTemplate);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Text('Delete'),
        ),
      ],
    );
  }
}
