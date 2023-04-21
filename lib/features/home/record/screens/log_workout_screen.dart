import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/record/services/services.dart';
import 'package:squatva/features/home/record/widgets/widgets.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
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

    Timer(Duration(milliseconds: 10), () => scrollController.jumpTo(scrollController.position.maxScrollExtent));
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              // await WorkoutService.logWorkout(context);
              logWorkoutBuilderNotifier.setInProgress = false;
              Navigator.pop(context);
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Exercises'),
                          Expanded(flex: 1, child: Container()),
                        ],
                      ),
                      const Divider(),
                      logWorkoutBuilderNotifier.exerciseSets.isNotEmpty ? _buildExerciseList(logWorkoutBuilderNotifier) : Text('Get started by adding an exercise'),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Exercise? result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const ExerciseSelectScreen()));
                  if (result == null) return;
                  setState(() {
                    logWorkoutBuilderNotifier.addNewExercise(result.id!);
                  });
                },
                child: Text('Add Exercise'),
              ),
              ElevatedButton(
                onPressed: () async {
                  logWorkoutBuilderNotifier.setInProgress = false;
                  logWorkoutBuilderNotifier.exerciseSets = [];
                  Navigator.pop(context);
                },
                child: Text('Cancel Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
