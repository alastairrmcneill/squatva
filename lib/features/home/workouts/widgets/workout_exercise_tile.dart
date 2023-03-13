// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class WorkoutExerciseTile extends StatelessWidget {
  final String exerciseIndex;
  final Map exerciseSet;
  const WorkoutExerciseTile({
    Key? key,
    required this.exerciseIndex,
    required this.exerciseSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkoutTemplateBuilderNotifier workoutTemplateBuilderNotifier = Provider.of<WorkoutTemplateBuilderNotifier>(context);
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context, listen: false);
    Exercise exercise = exerciseNotifier.exerciseFromId(exerciseSet['exerciseId']);
    final List<Map> sets = exerciseSet['sets'];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 1, child: Text(exercise.name)),
              PopupMenuButton(
                icon: Icon(Icons.more_vert_rounded),
                onSelected: (value) async {
                  if (value == WorkoutExerciseTileMenuItems.item1) {
                    //
                  } else if (value == WorkoutExerciseTileMenuItems.item2) {
                    workoutTemplateBuilderNotifier.removeExercise(exerciseIndex);
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: WorkoutExerciseTileMenuItems.item1,
                    child: Text('Add Tempo'),
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
          TextButton(
              onPressed: () {
                workoutTemplateBuilderNotifier.addSetToExercise(exerciseIndex);
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
