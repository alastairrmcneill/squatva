import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/services/workout_template_builder_notifier.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

showReorderBottomSheet(BuildContext context, WorkoutTemplateBuilderNotifier workoutTemplateBuilderNotifier) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
    builder: (context) => StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      SettingsNotifier settingsNotifier = Provider.of<SettingsNotifier>(context, listen: false);
      return Container(
        margin: const EdgeInsets.all(10),
        height: 300,
        child: ReorderableListView(
          buildDefaultDragHandles: true,
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) newIndex--;
            setState(() {
              workoutTemplateBuilderNotifier.reorderExercise(newIndex, oldIndex);
            });
          },
          children: [
            ...workoutTemplateBuilderNotifier.exerciseSets.map((exerciseSet) {
              int index = workoutTemplateBuilderNotifier.exerciseSets.indexOf(exerciseSet);
              ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context, listen: false);
              String name = '';
              if (exerciseSet is SingleExerciseSet) {
                name = exerciseNotifier.exerciseFromId(exerciseSet.exerciseID).name;
              } else {
                name = 'Superset';
              }
              return ListTile(
                key: ValueKey<int>(index),
                title: Text(name, style: TextStyle(color: settingsNotifier.darkMode ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).textTheme.bodyLarge!.color!)),
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
