import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/services/workout_template_builder_notifier.dart';

import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class ExerciseSetCard extends StatelessWidget {
  final int exerciseIndex;
  final SingleExerciseSet exerciseSet;
  const ExerciseSetCard({
    Key? key,
    required this.exerciseIndex,
    required this.exerciseSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkoutTemplateBuilderNotifier workoutTemplateBuilderNotifier = Provider.of<WorkoutTemplateBuilderNotifier>(context);
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context, listen: false);
    Exercise exercise = exerciseNotifier.exerciseFromId(exerciseSet.exerciseID);
    final List<dynamic> sets = exerciseSet.sets;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        children: [
          Row(
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
                      child: Text(
                        exercise.name,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert_rounded),
                onSelected: (value) async {
                  if (value == WorkoutExerciseTileMenuItems.item1) {
                    showReorderBottomSheet(context, workoutTemplateBuilderNotifier);
                  }
                  if (value == WorkoutExerciseTileMenuItems.item2) {
                    workoutTemplateBuilderNotifier.removeExercise(exerciseIndex);
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: WorkoutExerciseTileMenuItems.item1,
                    child: Text('Reorder Exercise'),
                  ),
                  PopupMenuItem(
                    value: WorkoutExerciseTileMenuItems.item2,
                    child: Text('Remove Execise'),
                  ),
                ],
              )
            ],
          ),
          const Divider(
            indent: 5,
            endIndent: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(width: 20),
              SizedBox(width: 30, child: Center(child: Text('Set'))),
              SizedBox(width: 90, child: Center(child: Text('Reps'))),
              SizedBox(width: 90, child: Center(child: Text('Weight'))),
            ],
          ),
          ...sets.asMap().entries.map((entry) {
            int setNumber = entry.key;
            int reps = entry.value['reps'] as int;
            double weight = entry.value['weight'] as double;

            return SetRow(
              exerciseIndex: exerciseIndex,
              setNumber: setNumber,
              reps: reps,
              weight: weight,
            );
          }).toList(),
          const Divider(
            indent: 5,
            endIndent: 5,
          ),
          TextButton(
              onPressed: () {
                workoutTemplateBuilderNotifier.addSetToExercise(exerciseIndex, null);
              },
              child: Text('Add Set')),
        ],
      ),
    );
  }
}

enum WorkoutExerciseTileMenuItems {
  item1,
  item2;
}
