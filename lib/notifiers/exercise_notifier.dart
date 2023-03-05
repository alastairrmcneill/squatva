import 'package:flutter/material.dart';
import 'package:squatva/models/models.dart';

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
}
