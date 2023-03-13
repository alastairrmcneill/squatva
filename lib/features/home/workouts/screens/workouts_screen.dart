import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  Widget _buildList(BuildContext context, ExerciseNotifier exerciseNotifier) {
    return Column(
      children: exerciseNotifier.filteredExerciseList
          .map(
            (exercise) => ListTile(
              title: Text(exercise.name),
              subtitle: Text('${exercise.musclesUsed.join(',')} \n${exercise.equipment}\n${exercise.exerciseCategory}'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExerciseDetailScreen(exercise: exercise),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context);
    return SafeArea(
      child: Column(
        children: [
          const Filter1(),
          exerciseNotifier.filteredExerciseList.isNotEmpty ? _buildList(context, exerciseNotifier) : Text('No exercises found'),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreateExerciseScreen(),
              ),
            ),
            child: Text('Create'),
          )
        ],
      ),
    );
  }
}
