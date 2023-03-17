// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/services/workout_template_builder_notifier.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';
import 'package:squatva/general/services/services.dart';
import 'package:squatva/general/services/workout_service.dart';

class CreateWorkoutTemplateScreen extends StatefulWidget {
  final WorkoutTemplate? workoutTemplate;
  const CreateWorkoutTemplateScreen({
    Key? key,
    this.workoutTemplate,
  }) : super(key: key);

  @override
  State<CreateWorkoutTemplateScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutTemplateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WorkoutTemplateBuilderNotifier workoutTemplateBuilderNotifier = Provider.of<WorkoutTemplateBuilderNotifier>(context, listen: false);
    workoutTemplateBuilderNotifier.reset();

    if (widget.workoutTemplate != null) {
      WorkoutTemplate startingPoint = widget.workoutTemplate!.copy();
      workoutTemplateBuilderNotifier.name = widget.workoutTemplate!.name;
      workoutTemplateBuilderNotifier.exerciseSets = widget.workoutTemplate!.exerciseSets;
      workoutTemplateBuilderNotifier.setStartingPoint = startingPoint;
      _nameTextEditingController.text = widget.workoutTemplate!.name;
    }
  }

  Widget _buildExerciseList(WorkoutTemplateBuilderNotifier workoutTemplateBuilderNotifier) {
    print(workoutTemplateBuilderNotifier.exerciseSets);
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

    if (widget.workoutTemplate == null) {
      await WorkoutService.createTemplate(context);
    } else {
      await WorkoutService.updateWorkoutTemplate(context, uid: widget.workoutTemplate!.uid);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    WorkoutTemplateBuilderNotifier workoutTemplateBuilderNotifier = Provider.of<WorkoutTemplateBuilderNotifier>(context);
    Timer(Duration(milliseconds: 10), () => scrollController.jumpTo(scrollController.position.maxScrollExtent));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutTemplate == null ? 'Create template' : 'Edit template'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.workoutTemplate == null) {
              Navigator.pop(context);
              return;
            }
            // Reset workout template to before edits
            WorkoutService.loadUserWorkoutTemplates(context);
            Navigator.pop(context);
            return;
          },
        ),
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
                    controller: scrollController,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameTextEditingController,
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
