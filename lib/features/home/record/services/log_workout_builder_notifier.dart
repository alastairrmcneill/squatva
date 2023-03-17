import 'package:flutter/material.dart';

class LogWorkoutBuilderNotifier extends ChangeNotifier {
  List exerciseSets = [];

  reset() {
    exerciseSets = [];
  }

  addNewExercise(String exerciseId) {
    exerciseSets.add({
      'exerciseId': exerciseId,
      'sets': [
        {
          'reps': 0,
          'weight': 0.0,
        }
      ],
    });
    notifyListeners();
  }

  removeExercise(int exerciseIndex) {
    exerciseSets.removeAt(exerciseIndex);
    notifyListeners();
  }

  addSetToExercise(int exerciseIndex) {
    int reps = 0;
    double weight = 0.0;
    if (exerciseSets[exerciseIndex]['sets'].isNotEmpty) {
      reps = exerciseSets[exerciseIndex]['sets'].last['reps'];
      weight = exerciseSets[exerciseIndex]['sets'].last['weight'];
    }
    exerciseSets[exerciseIndex]['sets'].add({
      'reps': reps,
      'weight': weight,
    });
    notifyListeners();
  }
}
