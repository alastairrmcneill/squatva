import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/record/screens/screens.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WorkoutTemplateNotifier workoutTemplateNotifier = Provider.of<WorkoutTemplateNotifier>(context);
    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LogWorkoutScreen())),
            child: Text('Quick Start'),
          ),
          Text('My Templates'),
          ...workoutTemplateNotifier.workoutTemplateList
              .map(
                (WorkoutTemplate workoutTemplate) => ListTile(
                  title: Text(workoutTemplate.name),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LogWorkoutScreen(
                        workoutTemplate: workoutTemplate,
                      ),
                    ),
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
