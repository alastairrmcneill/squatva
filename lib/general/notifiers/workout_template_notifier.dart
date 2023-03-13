import 'package:flutter/material.dart';
import 'package:squatva/general/models/models.dart';

class WorkoutTemplateNotifier extends ChangeNotifier {
  List<WorkoutTemplate> _workoutTemplateList = [];

  List<WorkoutTemplate> get workoutTemplateList => _workoutTemplateList;

  set addUserWorkoutTemplates(List<WorkoutTemplate> userWorkoutTemplates) {
    _workoutTemplateList = userWorkoutTemplates;
    notifyListeners();
  }
}
