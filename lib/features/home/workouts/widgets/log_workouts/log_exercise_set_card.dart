import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/services/services.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class LogExerciseSetCard extends StatelessWidget {
  final int exerciseIndex;
  final SingleExerciseSet exerciseSet;
  const LogExerciseSetCard({
    Key? key,
    required this.exerciseIndex,
    required this.exerciseSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogWorkoutBuilderNotifier logWorkoutBuilderNotifier = Provider.of<LogWorkoutBuilderNotifier>(context);
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context, listen: false);
    Exercise exercise = exerciseNotifier.exerciseFromId(exerciseSet.exerciseID);
    final List<dynamic> sets = exerciseSet.sets;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 45,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ExerciseDetailScreen(exercise: exercise),
                              ),
                            ),
                            child: Text(exercise.name),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert_rounded,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      onSelected: (value) async {
                        if (value == WorkoutExerciseTileMenuItems.item1) {
                          showReorderLogBottomSheet(context, logWorkoutBuilderNotifier);
                        }
                        if (value == WorkoutExerciseTileMenuItems.item1) {
                          // TODO: implement superset
                        }
                        if (value == WorkoutExerciseTileMenuItems.item3) {
                          logWorkoutBuilderNotifier.removeExercise(exerciseIndex);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: WorkoutExerciseTileMenuItems.item1,
                          child: Text('Reorder Execise'),
                        ),
                        // PopupMenuItem(
                        //   value: WorkoutExerciseTileMenuItems.item2,
                        //   child: Text('Add To Superset'),
                        // ),
                        PopupMenuItem(
                          value: WorkoutExerciseTileMenuItems.item3,
                          child: Text('Remove Execise'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
                    ),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Expanded(flex: 30, child: Center(child: Text('Set'))),
                          Expanded(flex: 80, child: Center(child: Text('Reps'))),
                          Expanded(flex: 80, child: Center(child: Text('Weight'))),
                          Expanded(flex: 40, child: Center(child: Text('Done'))),
                        ],
                      ),
                      const SizedBox(height: 5),
                      ...sets.asMap().entries.map((entry) {
                        int setNumber = entry.key;
                        int reps = entry.value['reps'] as int;
                        double weight = entry.value['weight'] as double;

                        return LogSetRow(
                          exerciseIndex: exerciseIndex,
                          setNumber: setNumber,
                          totalSets: sets.length - 1,
                          reps: reps,
                          weight: weight,
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      logWorkoutBuilderNotifier.addSetToExercise(exerciseIndex, null);
                    },
                    child: Text('Add Set')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum WorkoutExerciseTileMenuItems {
  item1,
  item2,
  item3;
}
