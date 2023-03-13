import 'package:flutter/material.dart';
import 'package:squatva/general/models/models.dart';

class WorkoutTemplateBuilderNotifier extends ChangeNotifier {
  String name = '';
  Map exerciseSets = {};
  int _exerciseCount = 0;

  reset() {
    name = '';
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
