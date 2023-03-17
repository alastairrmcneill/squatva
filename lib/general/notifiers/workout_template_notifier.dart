import 'package:flutter/material.dart';
import 'package:squatva/general/models/models.dart';

class WorkoutTemplateNotifier extends ChangeNotifier {
  List<WorkoutTemplate> _workoutTemplateList = [];
  WorkoutTemplate? _currentWorkoutTemplate;

  List<WorkoutTemplate> get workoutTemplateList => _workoutTemplateList;
  WorkoutTemplate? get currentWorkoutTemplate => _currentWorkoutTemplate;

  set setCurrentWorkoutTemplate(WorkoutTemplate workoutTemplate) {
    _currentWorkoutTemplate = workoutTemplate;
    notifyListeners();
  }

  set addUserWorkoutTemplates(List<WorkoutTemplate> userWorkoutTemplates) {
    _workoutTemplateList = userWorkoutTemplates;
    notifyListeners();
  }

  replaceWorkoutTemplate(WorkoutTemplate workoutTemplate) {
    int index = _workoutTemplateList.indexWhere((element) => element.uid == workoutTemplate.uid);
    if (index != -1) {
      _workoutTemplateList[index] = workoutTemplate;
      notifyListeners();
    }
  }

  removeWorkoutTemplate(WorkoutTemplate workoutTemplate) {
    int index = _workoutTemplateList.indexWhere((element) => element.uid == workoutTemplate.uid);
    if (index != -1) {
      _workoutTemplateList.removeAt(index);
      notifyListeners();
    }
  }

  reset() {
    _workoutTemplateList = [];
  }
}
