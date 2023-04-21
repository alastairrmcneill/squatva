import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/record/screens/screens.dart';
import 'package:squatva/features/home/record/services/services.dart';
import 'package:squatva/features/home/record/widgets/widgets.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WorkoutTemplateNotifier workoutTemplateNotifier = Provider.of<WorkoutTemplateNotifier>(context);
    LogWorkoutBuilderNotifier logWorkoutBuilderNotifier = Provider.of<LogWorkoutBuilderNotifier>(context);

    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: logWorkoutBuilderNotifier.inProgress ? const CurrentWorkoutOverlay() : const SizedBox(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
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
                child: Text('Quick Start'),
              ),
              Text('My Templates'),
              ...workoutTemplateNotifier.workoutTemplateList
                  .map(
                    (WorkoutTemplate workoutTemplate) => ListTile(
                        title: Text(workoutTemplate.name),
                        onTap: () async {
                          String action = 'New';
                          if (logWorkoutBuilderNotifier.inProgress) {
                            action = await showContinueLoggingWorkoutDialog(context);
                          }

                          if (action == 'New') {
                            logWorkoutBuilderNotifier.setInProgress = true;
                            logWorkoutBuilderNotifier.exerciseSets = workoutTemplate.exerciseSets;
                            logWorkoutBuilderNotifier.markAllAsNotDone();
                            Navigator.push(context, MaterialPageRoute(builder: (_) => LogWorkoutScreen()));
                          } else if (action == 'Continue') {
                            logWorkoutBuilderNotifier.setInProgress = true;
                            Navigator.push(context, MaterialPageRoute(builder: (_) => LogWorkoutScreen()));
                          }
                        }),
                  )
                  .toList()
            ],
          ),
        ],
      ),
    );
  }
}
