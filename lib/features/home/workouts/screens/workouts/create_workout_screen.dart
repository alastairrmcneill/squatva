import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/services/workout_template_builder_notifier.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';
import 'package:squatva/general/services/services.dart';
import 'package:squatva/general/services/workout_service.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({super.key});

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WorkoutTemplateBuilderNotifier workoutTemplateBuilderNotifier = Provider.of<WorkoutTemplateBuilderNotifier>(context, listen: false);
    workoutTemplateBuilderNotifier.reset();
  }

  Widget _buildExerciseList(WorkoutTemplateBuilderNotifier workoutTemplateBuilderNotifier) {
    return Column(
      children: [
        ...workoutTemplateBuilderNotifier.exerciseSets.keys
            .map(
              (exerciseIndex) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ExerciseSetCard(
                  exerciseIndex: exerciseIndex,
                  exerciseSet: workoutTemplateBuilderNotifier.exerciseSets[exerciseIndex],
                ),
              ),
            )
            .toList(),
      ],
    );
  }

  Future<void> _submit(WorkoutTemplateBuilderNotifier workoutTemplateBuilderNotifier) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    // TODO check the exercises have sets

    await WorkoutService.createTemplate(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    WorkoutTemplateBuilderNotifier workoutTemplateBuilderNotifier = Provider.of<WorkoutTemplateBuilderNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New workout template'),
        actions: [
          TextButton(
            onPressed: () async {
              await _submit(workoutTemplateBuilderNotifier);
            },
            child: const Text(
              'Save',
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
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Workout name',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Required";
                            }
                          },
                          onSaved: (value) {
                            workoutTemplateBuilderNotifier.name = value!;
                            workoutTemplateBuilderNotifier.name = value;
                          },
                        ),
                        Row(
                          children: [
                            Text('Exercises'),
                            Expanded(flex: 1, child: Container()),
                          ],
                        ),
                        const Divider(),
                        workoutTemplateBuilderNotifier.exerciseSets.isNotEmpty ? _buildExerciseList(workoutTemplateBuilderNotifier) : Text('Get started by adding an exercise'),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Exercise? result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const ExerciseSelectScreen()));
                  if (result == null) return;
                  setState(() {
                    workoutTemplateBuilderNotifier.addNewExercise(result.id!);
                  });
                },
                child: Text('Add Exercise'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
