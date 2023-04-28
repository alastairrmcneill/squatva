import 'package:flutter/material.dart';
import 'package:squatva/general/models/models.dart';

class LogWorkoutBuilderNotifier extends ChangeNotifier {
  List<ExerciseSet> exerciseSets = [];
  bool inProgress = false;

  int get getTotalExercises {
    int total = 0;
    for (var exerciseSet in exerciseSets) {
      if (exerciseSet is SingleExerciseSet) {
        for (var set in exerciseSet.sets) {
          total++;
        }
      } else if (exerciseSet is Superset) {
        for (var singleExerciseSet in exerciseSet.exercises) {
          for (var set in singleExerciseSet.sets) {
            total++;
          }
        }
      }
    }
    return total;
  }

  int get remainingExercises {
    int remaining = 0;
    for (var exerciseSet in exerciseSets) {
      if (exerciseSet is SingleExerciseSet) {
        for (var set in exerciseSet.sets) {
          if (!set['completed']) remaining++;
        }
      } else if (exerciseSet is Superset) {
        for (var singleExerciseSet in exerciseSet.exercises) {
          for (var set in singleExerciseSet.sets) {
            if (!set['completed']) remaining++;
          }
        }
      }
    }
    return remaining;
  }

  set setInProgress(inProgress) {
    this.inProgress = inProgress;
    notifyListeners();
  }

  reset() {
    exerciseSets = [];
  }

  addNewExercise(String exerciseId) {
    exerciseSets.add(
      SingleExerciseSet(
        exerciseID: exerciseId,
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
        print('reps');
        print((exerciseSets[exerciseIndex] as SingleExerciseSet).sets.last['reps']);
        reps = (exerciseSets[exerciseIndex] as SingleExerciseSet).sets.last['reps'];
        weight = (exerciseSets[exerciseIndex] as SingleExerciseSet).sets.last['weight'];
      }
      (exerciseSets[exerciseIndex] as SingleExerciseSet).sets.add({
        'reps': reps,
        'weight': weight,
        'completed': false,
      });
    }
    //  else if (exerciseSets[exerciseIndex] is Superset) {
    //   if ((exerciseSets[exerciseIndex] as Superset).exercises[superSetExerciseIndex!].sets.isNotEmpty) {
    //     reps = (exerciseSets[exerciseIndex] as Superset).exercises[superSetExerciseIndex].sets.last['reps'];
    //     weight = (exerciseSets[exerciseIndex] as Superset).exercises[superSetExerciseIndex].sets.last['weight'];
    //   }
    //   (exerciseSets[exerciseIndex] as Superset).exercises[superSetExerciseIndex].sets.add({
    //     'reps': reps,
    //     'weight': weight,
    //     'completed': false,
    //   });
    // }
    notifyListeners();
  }

  removeSetFromExercise(int exerciseIndex, int setNumber, int? superSetExerciseIndex) {
    if (exerciseSets[exerciseIndex] is SingleExerciseSet) {
      (exerciseSets[exerciseIndex] as SingleExerciseSet).sets.removeAt(setNumber);
    } else if (exerciseSets[exerciseIndex] is Superset) {
      (exerciseSets[exerciseIndex] as Superset).exercises[superSetExerciseIndex!].sets.removeAt(setNumber);
    }

    notifyListeners();
  }

  markSetAsDone(int exerciseIndex, int? superSetExerciseIndex, int setNumber, bool done) {
    if (exerciseSets[exerciseIndex] is SingleExerciseSet) {
      (exerciseSets[exerciseIndex] as SingleExerciseSet).sets[setNumber]['completed'] = done;
    } else if (exerciseSets[exerciseIndex] is Superset) {
      (exerciseSets[exerciseIndex] as Superset).exercises[superSetExerciseIndex!].sets[setNumber]['completed'] = done;
    }
    notifyListeners();
  }

  markAllAsNotDone() {
    for (var exerciseSet in exerciseSets) {
      if (exerciseSet is SingleExerciseSet) {
        for (var i = 0; i < exerciseSet.sets.length; i++) {
          exerciseSet.sets[i]['completed'] = false;
        }
      } else if (exerciseSet is Superset) {
        for (var superSetExerciseSet in exerciseSet.exercises) {
          for (var i = 0; i < superSetExerciseSet.sets.length; i++) {
            superSetExerciseSet.sets[i]['completed'] = false;
          }
        }
      }
    }
  }

  void updateRep(int exerciseSetIndex, int? superSetIndex, int setNumber, int reps) {
    if (exerciseSets[exerciseSetIndex] is SingleExerciseSet) {
      (exerciseSets[exerciseSetIndex] as SingleExerciseSet).sets[setNumber]['reps'] = reps;
    } else {
      (exerciseSets[exerciseSetIndex] as Superset).exercises[superSetIndex!].sets[setNumber]['reps'] = reps;
    }
  }

  void updateWeight(int exerciseSetIndex, int? superSetIndex, int setNumber, double weight) {
    if (exerciseSets[exerciseSetIndex] is SingleExerciseSet) {
      (exerciseSets[exerciseSetIndex] as SingleExerciseSet).sets[setNumber]['weight'] = weight;
    } else {
      (exerciseSets[exerciseSetIndex] as Superset).exercises[superSetIndex!].sets[setNumber]['weight'] = weight;
    }
  }
}
