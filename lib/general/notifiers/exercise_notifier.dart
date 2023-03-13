import 'package:flutter/material.dart';
import 'package:squatva/general/models/models.dart';

class ExerciseNotifier extends ChangeNotifier {
  List<Exercise> _exerciseList = defaultExercises;
  List<Exercise> _filteredExerciseList = defaultExercises;
  String _filterString = '';
  List<String> _filterEquipmentTags = [];
  List<String> _filterCategoryTags = [];
  List<String> _filterLimbTags = [];

  List<Exercise> get exerciseList => _exerciseList;
  List<Exercise> get filteredExerciseList => _filteredExerciseList;
  List<String> get filterEquipmentTags => _filterEquipmentTags;
  List<String> get filterCategoryTags => _filterCategoryTags;
  List<String> get filterLimbTags => _filterLimbTags;

  set addUserExercises(List<Exercise> userExercises) {
    _exerciseList = defaultExercises + userExercises;
    filter();
    notifyListeners();
  }

  replaceExercise(Exercise exercise) {
    int index = exerciseList.indexWhere((element) => element.id == exercise.id);
    if (index != -1) {
      _exerciseList[index] = exercise;
      filter();
      notifyListeners();
    }
  }

  removeExercise(Exercise exercise) {
    int index = exerciseList.indexWhere((element) => element.id == exercise.id);
    if (index != -1) {
      _exerciseList.removeAt(index);
      filter();
      notifyListeners();
    }
  }

  setFilterString(String filterString) {
    _filterString = filterString;
    filter();
  }

  setFilterTags({required List<String>? equipmentTags, required List<String>? categoryTags, required List<String>? limbTags}) {
    if (equipmentTags != null) _filterEquipmentTags = equipmentTags;
    if (categoryTags != null) _filterCategoryTags = categoryTags;
    if (limbTags != null) _filterLimbTags = limbTags;
    filter();
  }

  filter() {
    List<Exercise> _runningList = _exerciseList;
    if (_filterEquipmentTags.isNotEmpty) {
      _runningList = _runningList.where((element) => _filterEquipmentTags.contains(element.equipment)).toList();
    }
    if (_filterCategoryTags.isNotEmpty) {
      _runningList = _runningList.where((element) => _filterCategoryTags.contains(element.exerciseCategory)).toList();
    }
    if (_filterLimbTags.isNotEmpty) {
      _runningList = _runningList.where((element) => _filterLimbTags.contains(element.limbInvolvement)).toList();
    }

    if (_filterString != "") {
      _runningList = _runningList.where((element) {
        if (element.name.toLowerCase().contains(_filterString.toLowerCase())) {
          return true;
        }
        for (var muscle in element.musclesUsed) {
          if (muscle.toLowerCase().contains(_filterString.toLowerCase())) {
            return true;
          }
        }
        return false;
      }).toList();
    }
    _filteredExerciseList = _runningList;
    notifyListeners();
  }
}
