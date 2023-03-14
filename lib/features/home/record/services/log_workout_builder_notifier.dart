import 'package:flutter/material.dart';

class LogWorkoutBuilderNotifier extends ChangeNotifier {
  Map exerciseSets = {};
  int _exerciseCount = 0;

  reset() {
    exerciseSets = {};
  }

  addNewExercise(String exerciseId) {
    exerciseSets[_exerciseCount.toString()] = {
      'exerciseId': exerciseId,
      'sets': [
        {
          'reps': 0,
          'weight': 0.0,
        }
      ],
    };
    _exerciseCount++;
    notifyListeners();
  }

  removeExercise(String exerciseIndex) {
    exerciseSets.remove(exerciseIndex);
    notifyListeners();
  }

  addSetToExercise(String exerciseIndex) {
    exerciseSets[exerciseIndex]['sets'].add({
      'reps': 0,
      'weight': 0.0,
    });
    notifyListeners();
  }
}
