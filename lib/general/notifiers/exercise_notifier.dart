import 'package:flutter/material.dart';
import 'package:squatva/general/models/models.dart';

class ExerciseNotifier extends ChangeNotifier {
  List<Exercise> _exerciseList = defaultExercises;

  List<Exercise> get exerciseList => _exerciseList;

  set addExercise(Exercise exercise) {
    _exerciseList.add(exercise);
    notifyListeners();
  }

  set addUserExercises(List<Exercise> userExercises) {
    _exerciseList = defaultExercises + userExercises;
    notifyListeners();
  }

  replaceExercise(Exercise exercise) {
    int index = exerciseList.indexWhere((element) => element.id == exercise.id);
    if (index != -1) {
      _exerciseList[index] = exercise;
      notifyListeners();
    }
  }

  removeExercise(Exercise exercise) {
    int index = exerciseList.indexWhere((element) => element.id == exercise.id);
    if (index != -1) {
      _exerciseList.removeAt(index);
      notifyListeners();
    }
  }
}
