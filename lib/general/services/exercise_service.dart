import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/general/services/services.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/exercise_notifier.dart';

class ExerciseService {
  static Future create(BuildContext context, {required Exercise exercise}) async {
    // Link to user
    Exercise newExercise = exercise.copy(userID: AuthService.currentUserId);

    // Write to database
    await ExerciseDatabase.create(context, exercise: newExercise);

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

  static Future updateExercise(BuildContext context, {required Exercise newExercise}) async {
    // Re-write exercise
    await ExerciseDatabase.update(context, exercise: newExercise);

    // Update notifier
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context, listen: false);
    exerciseNotifier.replaceExercise(newExercise);
  }

  static Future deleteExcercise(BuildContext context, {required Exercise exercise}) async {
    // Delete from exercise database
    await ExerciseDatabase.delete(context, exercise: exercise);

    // Remove from notifier
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context, listen: false);
    exerciseNotifier.removeExercise(exercise);
  }
}
