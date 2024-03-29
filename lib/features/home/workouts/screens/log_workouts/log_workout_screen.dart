import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/services/services.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/models/models.dart';

class LogWorkoutScreen extends StatefulWidget {
  final WorkoutTemplate? workoutTemplate;
  const LogWorkoutScreen({
    Key? key,
    this.workoutTemplate,
  }) : super(key: key);

  @override
  State<LogWorkoutScreen> createState() => _LogWorkoutScreenState();
}

class _LogWorkoutScreenState extends State<LogWorkoutScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    LogWorkoutBuilderNotifier logWorkoutBuilderNotifier = Provider.of<LogWorkoutBuilderNotifier>(context, listen: false);

    if (widget.workoutTemplate != null) {
      logWorkoutBuilderNotifier.exerciseSets = widget.workoutTemplate!.exerciseSets;
    }
  }

  Widget _buildStartingText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Column(
        children: [
          Text(
            'Get Started',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 5),
          Text(
            'Add an exercise to start your workout',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseList(LogWorkoutBuilderNotifier logWorkoutBuilderNotifier) {
    return Column(
      children: [
        ...logWorkoutBuilderNotifier.exerciseSets.map((exerciseSet) {
          int index = logWorkoutBuilderNotifier.exerciseSets.indexOf(exerciseSet);

          if (exerciseSet is SingleExerciseSet) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: LogExerciseSetCard(
                exerciseIndex: index,
                exerciseSet: exerciseSet as SingleExerciseSet,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: LogSuperSetCard(
                exerciseIndex: index,
                superset: exerciseSet as Superset,
              ),
            );
          }
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    LogWorkoutBuilderNotifier logWorkoutBuilderNotifier = Provider.of<LogWorkoutBuilderNotifier>(context);

    // Timer(Duration(milliseconds: 10), () => scrollController.jumpTo(scrollController.position.maxScrollExtent));
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              // // await WorkoutService.logWorkout(context);
              // await showFinishLoggingWorkoutDialog(context);
              // logWorkoutBuilderNotifier.setInProgress = false;

              // Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SaveWorkoutScreen()));
            },
            child: const Text(
              "Finish Workout",
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              logWorkoutBuilderNotifier.exerciseSets.isEmpty ? _buildStartingText() : _buildExerciseList(logWorkoutBuilderNotifier),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: ElevatedButton(
                    onPressed: () async {
                      Exercise? result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const ExerciseSelectScreen()));
                      if (result == null) return;
                      setState(() {
                        logWorkoutBuilderNotifier.addNewExercise(result.id!);
                      });
                    },
                    child: const Text('Add Exercise'),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: TextButton(
                    onPressed: () async {
                      logWorkoutBuilderNotifier.setInProgress = false;
                      logWorkoutBuilderNotifier.exerciseSets = [];
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel Workout',
                      style: TextStyle(color: Colors.red[600]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
