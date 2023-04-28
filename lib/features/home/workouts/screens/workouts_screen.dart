import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/general/widgets/widgets.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';

import 'package:squatva/general/notifiers/notifiers.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WorkoutTemplateNotifier workoutTemplateNotifier = Provider.of<WorkoutTemplateNotifier>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurrentWorkoutOverlay(),
            RecordWorkoutButton(),
            WorkoutTemplateList(
              title: 'My Templates',
              workoutTemplates: workoutTemplateNotifier.workoutTemplateList,
            ),
            const SizedBox(height: 20),
            WorkoutTemplateList(
              title: 'Shared with me',
              workoutTemplates: workoutTemplateNotifier.workoutTemplateList,
            ),
          ],
        ),
      ),
    );
  }
}
