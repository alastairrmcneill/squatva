import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class ExerciseSelectScreen extends StatelessWidget {
  const ExerciseSelectScreen({super.key});

  Widget _buildList(BuildContext context, ExerciseNotifier exerciseNotifier) {
    return Column(
      children: exerciseNotifier.filteredExerciseList
          .map(
            (Exercise exercise) => ListTile(
              title: Text(exercise.name),
              onTap: () {
                Navigator.pop(context, exercise);
              },
              trailing: IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExerciseDetailScreen(exercise: exercise))),
                icon: Icon(Icons.chevron_right_rounded),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ExerciseFilter(),
          exerciseNotifier.filteredExerciseList.isNotEmpty ? _buildList(context, exerciseNotifier) : Text('No exercises found'),
        ],
      ),
    );
  }
}
