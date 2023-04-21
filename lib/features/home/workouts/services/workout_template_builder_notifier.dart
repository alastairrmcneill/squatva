import 'package:flutter/material.dart';
import 'package:squatva/general/models/models.dart';

class WorkoutTemplateBuilderNotifier extends ChangeNotifier {
  String name = '';
  List<ExerciseSet> exerciseSets = [];

  reset() {
    name = '';
    exerciseSets = [];
  }

  addNewExercise(String exerciseID) {
    exerciseSets.add(
      SingleExerciseSet(
        exerciseID: exerciseID,
        sets: [
          {
            'reps': 0,
            'weight': 0.0,
            'completed': false,
          }
        ],
      ),
    );

    notifyListeners();
  }

  removeExercise(int exerciseIndex) {
    exerciseSets.removeAt(exerciseIndex);
    notifyListeners();
  }

  reorderExercise(int newIndex, int oldIndex) {
    final item = exerciseSets.removeAt(oldIndex);
    exerciseSets.insert(newIndex, item);
    notifyListeners();
  }

  addSetToExercise(int exerciseIndex, int? superSetExerciseIndex) {
    int reps = 0;
    double weight = 0.0;
    if (exerciseSets[exerciseIndex] is SingleExerciseSet) {
      if ((exerciseSets[exerciseIndex] as SingleExerciseSet).sets.isNotEmpty) {
        reps = (exerciseSets[exerciseIndex] as SingleExerciseSet).sets.last['reps'];
        weight = (exerciseSets[exerciseIndex] as SingleExerciseSet).sets.last['weight'];
      }
      (exerciseSets[exerciseIndex] as SingleExerciseSet).sets.add({
        'reps': reps,
        'weight': weight,
        'completed': false,
      });
    } else if (exerciseSets[exerciseIndex] is Superset) {
      if ((exerciseSets[exerciseIndex] as Superset).exercises[superSetExerciseIndex!].sets.isNotEmpty) {
        reps = (exerciseSets[exerciseIndex] as Superset).exercises[superSetExerciseIndex].sets.last['reps'];
        weight = (exerciseSets[exerciseIndex] as Superset).exercises[superSetExerciseIndex].sets.last['weight'];
      }
      (exerciseSets[exerciseIndex] as Superset).exercises[superSetExerciseIndex].sets.add({
        'reps': reps,
        'weight': weight,
        'completed': false,
      });
    }
    notifyListeners();
  }

  remoteSetFromExercise(int exerciseIndex, int setNumber, int? superSetExerciseIndex) {
    if (exerciseSets[exerciseIndex] is SingleExerciseSet) {
      (exerciseSets[exerciseIndex] as SingleExerciseSet).sets.removeAt(setNumber);
    } else if (exerciseSets[exerciseIndex] is Superset) {
      (exerciseSets[exerciseIndex] as Superset).exercises[superSetExerciseIndex!].sets.removeAt(setNumber);
    }

    notifyListeners();
  }
}
