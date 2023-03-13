import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/services/workout_template_builder_notifier.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';
import 'package:squatva/general/services/services.dart';
import 'package:squatva/general/services/workout_template_database.dart';

class WorkoutService {
  static Future createTemplate(BuildContext context) async {
    WorkoutTemplateBuilderNotifier workoutTemplateBuilderNotifier = Provider.of<WorkoutTemplateBuilderNotifier>(context, listen: false);
    // Link to user
    String name = workoutTemplateBuilderNotifier.name;
    Map exerciseSets = workoutTemplateBuilderNotifier.exerciseSets;

    WorkoutTemplate workoutTemplate = WorkoutTemplate(name: name, userID: AuthService.currentUserId!, exerciseSets: exerciseSets);

    // Write to database
    await WorkoutTemplateDatabase.create(context, workoutTemplate: workoutTemplate);

    // Load User Workout Templates
    await loadUserWorkoutTemplates(context);
  }

  static Future loadUserWorkoutTemplates(BuildContext context) async {
    // Read from Database
    List<WorkoutTemplate> workoutTemplateList = await WorkoutTemplateDatabase.readMyWorkoutTemplates(context);

    // Update notifier
    WorkoutTemplateNotifier workoutTemplateNotifier = Provider.of<WorkoutTemplateNotifier>(context, listen: false);
    workoutTemplateNotifier.addUserWorkoutTemplates = workoutTemplateList;
  }
}
