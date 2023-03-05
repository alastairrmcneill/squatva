import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/models/models.dart';
import 'package:squatva/notifiers/exercise_notifier.dart';
import 'package:squatva/services/services.dart';

class ExerciseService {
  static Future create(BuildContext context, {required Exercise exercise}) async {
    // Write to database
    await ExerciseDatabase.create(context, exercise: exercise);

    // Read from database
    List<Exercise> userExerciseList = await ExerciseDatabase.readMyExercises(context);

    // Update Notifier
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context, listen: false);
    exerciseNotifier.addUserExercises = userExerciseList;
  }

  static Future loadUserExercises(BuildContext context) async {
    // Read from database
    List<Exercise> userExerciseList = await ExerciseDatabase.readMyExercises(context);

    // Update Notifier
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context, listen: false);
    exerciseNotifier.addUserExercises = userExerciseList;
  }
}
