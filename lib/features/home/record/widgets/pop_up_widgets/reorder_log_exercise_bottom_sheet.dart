import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/record/services/log_workout_builder_notifier.dart';
import 'package:squatva/features/home/workouts/services/workout_template_builder_notifier.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

showReorderLogBottomSheet(BuildContext context, LogWorkoutBuilderNotifier logWorkoutBuilderNotifier) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
    builder: (context) => StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: const EdgeInsets.all(10),
        height: 300,
        child: ReorderableListView(
          buildDefaultDragHandles: true,
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) newIndex--;
            setState(() {
              logWorkoutBuilderNotifier.reorderExercise(newIndex, oldIndex);
            });
          },
          children: [
            ...logWorkoutBuilderNotifier.exerciseSets.map((exerciseSet) {
              int index = logWorkoutBuilderNotifier.exerciseSets.indexOf(exerciseSet);
              ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context, listen: false);
              String name = '';
              if (exerciseSet is SingleExerciseSet) {
                name = exerciseNotifier.exerciseFromId(exerciseSet.exerciseID).name;
              } else {
                name = 'Superset';
              }
              return ListTile(
                key: ValueKey<int>(index),
                title: Text(name),
                trailing: ReorderableDragStartListener(
                  key: ValueKey<double>(double.parse('$index.$index')),
                  index: index,
                  child: const Icon(Icons.drag_handle),
                ),
              );
            }).toList()
          ],
        ),
      );
    }),
  ).whenComplete(() {});
}
