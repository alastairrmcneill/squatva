import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/services/services.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/support/wrapper.dart';

class SaveWorkoutScreen extends StatelessWidget {
  const SaveWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LogWorkoutBuilderNotifier logWorkoutBuilderNotifier = Provider.of<LogWorkoutBuilderNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              logWorkoutBuilderNotifier.setInProgress = false;
              // TODO: Save workout

              // TODO: Push to summary page
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wrapper()), (_) => false);
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Name'),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Description'),
            ),
            ImageDisplay(),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  showDiscardWorkoutPopup(context);
                },
                child: const Text(
                  'Discard Workout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
