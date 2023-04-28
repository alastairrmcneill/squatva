import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/services/services.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';

class RecordWorkoutButton extends StatelessWidget {
  const RecordWorkoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    LogWorkoutBuilderNotifier logWorkoutBuilderNotifier = Provider.of<LogWorkoutBuilderNotifier>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: SizedBox(
        width: double.infinity,
        height: 44,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          child: ElevatedButton(
            onPressed: () async {
              String action = 'New';
              if (logWorkoutBuilderNotifier.inProgress) {
                action = await showContinueLoggingWorkoutDialog(context);
              }

              if (action == 'New') {
                logWorkoutBuilderNotifier.setInProgress = true;
                logWorkoutBuilderNotifier.exerciseSets = [];
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LogWorkoutScreen()));
              } else if (action == 'Continue') {
                logWorkoutBuilderNotifier.setInProgress = true;
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LogWorkoutScreen()));
              }
            },
            child: const Text('Start Empty Workout'),
          ),
        ),
      ),
    );
  }
}
