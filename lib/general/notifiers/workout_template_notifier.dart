import 'package:flutter/material.dart';
import 'package:squatva/general/models/models.dart';

class WorkoutTemplateNotifier extends ChangeNotifier {
  List<WorkoutTemplate> _workoutTemplateList = [];

  List<WorkoutTemplate> get workoutTemplateList => _workoutTemplateList;

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
}
