import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/services/services.dart';
import 'package:squatva/general/models/models.dart';
import 'package:intl/intl.dart';

class LogSetRow extends StatelessWidget {
  final int exerciseIndex;
  final int? superSetIndex;
  final int setNumber;
  final int totalSets;
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
    required this.totalSets,
  }) {
    repsContorller = TextEditingController(text: reps.toString());
    String formatQuantity(double v) {
      if (v == null) return '';

      NumberFormat formatter = NumberFormat();
      formatter.minimumFractionDigits = 0;
      formatter.maximumFractionDigits = 2;
      return formatter.format(v);
    }

    weightController = TextEditingController(text: formatQuantity(weight)); // weight.toStringAsFixed(weight.truncateToDouble() == weight ? 0 : 1));
  }

  Widget _buildDivider(context) {
    return SizedBox(
      width: 1,
      height: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: setNumber != 0 && setNumber != totalSets ? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5) : null,
          gradient: totalSets == 0
              ? LinearGradient(
                  colors: [Colors.transparent, Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )
              : setNumber == 0
                  ? LinearGradient(
                      colors: [Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )
                  : setNumber == totalSets
                      ? LinearGradient(
                          colors: [Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5), Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      : null,
        ),
      ),
    );
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
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(flex: 30, child: Center(child: Text((setNumber + 1).toString()))),
            _buildDivider(context),
            Expanded(
              flex: 80,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        logWorkoutBuilderNotifier.updateRep(exerciseIndex, superSetIndex, setNumber, _reps);
                      }
                    },
                  ),
                ),
              ),
            ),
            _buildDivider(context),
            Expanded(
              flex: 80,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: weightController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '-',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        double _weight = double.parse(value);
                        logWorkoutBuilderNotifier.updateWeight(exerciseIndex, superSetIndex, setNumber, _weight);
                      }
                    },
                  ),
                ),
              ),
            ),
            _buildDivider(context),
            Expanded(
              flex: 40,
              child: Center(
                child: Checkbox(
                  value: logWorkoutBuilderNotifier.exerciseSets[exerciseIndex] is SingleExerciseSet
                      ? (logWorkoutBuilderNotifier.exerciseSets[exerciseIndex] as SingleExerciseSet).sets[setNumber]['completed']
                      : (logWorkoutBuilderNotifier.exerciseSets[exerciseIndex] as Superset).exercises[superSetIndex!].sets[setNumber]['completed'],
                  onChanged: (value) {
                    logWorkoutBuilderNotifier.markSetAsDone(exerciseIndex, superSetIndex, setNumber, value!);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
