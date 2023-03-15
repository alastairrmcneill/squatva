import 'package:flutter/material.dart';
import 'package:squatva/general/models/models.dart';

class WorkoutNotifier extends ChangeNotifier {
  List<Workout> _workoutList = [];

  List<Workout> get workoutList => _workoutList;

  set addUserWorkouts(List<Workout> userWorkout) {
    _workoutList = userWorkout;
    notifyListeners();
  }

  reset() {
    _workoutList = [];
  }
}
