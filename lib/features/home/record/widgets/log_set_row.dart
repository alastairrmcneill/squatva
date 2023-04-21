import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/record/services/services.dart';
import 'package:squatva/general/models/models.dart';

class LogSetRow extends StatelessWidget {
  final int exerciseIndex;
  final int? superSetIndex;
  final int setNumber;
  final int reps;
  final double weight;
  late TextEditingController repsContorller;
  late TextEditingController weightController;
  LogSetRow({
    Key? key,
    required this.exerciseIndex,
    required this.setNumber,
    required this.reps,
    required this.weight,
    this.superSetIndex,
  }) {
    repsContorller = TextEditingController(text: reps.toString());
    weightController = TextEditingController(text: weight.toString());
  }

  @override
  Widget build(BuildContext context) {
    LogWorkoutBuilderNotifier logWorkoutBuilderNotifier = Provider.of<LogWorkoutBuilderNotifier>(context);
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        logWorkoutBuilderNotifier.removeSetFromExercise(exerciseIndex, setNumber, superSetIndex);
      },
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20),
          SizedBox(width: 30, child: Center(child: Text((setNumber + 1).toString()))),
          SizedBox(
            width: 90,
            height: 30,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: repsContorller,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: '-',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      int _reps = int.parse(value);

                      if (logWorkoutBuilderNotifier.exerciseSets[exerciseIndex] is SingleExerciseSet) {
                        (logWorkoutBuilderNotifier.exerciseSets[exerciseIndex] as SingleExerciseSet).sets[setNumber]['reps'] = reps;
                      } else {
                        (logWorkoutBuilderNotifier.exerciseSets[exerciseIndex] as Superset).exercises[superSetIndex!].sets[setNumber]['reps'] = reps;
                      }
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            width: 90,
            height: 30,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: weightController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: '-',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      double weight = double.parse(value);
                      if (logWorkoutBuilderNotifier.exerciseSets[exerciseIndex] is SingleExerciseSet) {
                        (logWorkoutBuilderNotifier.exerciseSets[exerciseIndex] as SingleExerciseSet).sets[setNumber]['weight'] = weight;
                      } else {
                        (logWorkoutBuilderNotifier.exerciseSets[exerciseIndex] as Superset).exercises[superSetIndex!].sets[setNumber]['weight'] = weight;
                      }
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            width: 90,
            height: 30,
            child: Checkbox(
              value: logWorkoutBuilderNotifier.exerciseSets[exerciseIndex] is SingleExerciseSet
                  ? (logWorkoutBuilderNotifier.exerciseSets[exerciseIndex] as SingleExerciseSet).sets[setNumber]['completed']
                  : (logWorkoutBuilderNotifier.exerciseSets[exerciseIndex] as Superset).exercises[superSetIndex!].sets[setNumber]['completed'],
              onChanged: (value) {
                logWorkoutBuilderNotifier.markSetAsDone(exerciseIndex, superSetIndex, setNumber, value!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
