import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  Widget _buildList(BuildContext context, WorkoutTemplateNotifier workoutTemplateNotifier) {
    return Column(
      children: workoutTemplateNotifier.workoutTemplateList
          .map(
            (WorkoutTemplate workoutTemplate) => ListTile(
              title: Text(workoutTemplate.name),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WorkoutTemplateDetailScreen(workoutTemplate: workoutTemplate),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    WorkoutTemplateNotifier workoutTemplateNotifier = Provider.of<WorkoutTemplateNotifier>(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            workoutTemplateNotifier.workoutTemplateList.isNotEmpty ? _buildList(context, workoutTemplateNotifier) : Text('No workout templates found'),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateWorkoutTemplateScreen(),
                ),
              ),
              child: Text('Create workout template'),
            )
          ],
        ),
      ),
    );
  }
}
