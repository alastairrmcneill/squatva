import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/general/notifiers/notifiers.dart';
import 'package:squatva/general/services/services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WorkoutNotifier workoutNotifier = Provider.of<WorkoutNotifier>(
      context,
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          workoutNotifier.workoutList.isNotEmpty
              ? Column(
                  children: workoutNotifier.workoutList.map((e) => Text(e.uid)).toList(),
                )
              : const Text('''This is where we will build out the user profile where they can see their stats, workout activity, previous workouts, settings etc.'''),
          ElevatedButton(
            onPressed: () async {
              AuthService.signOut(context);
            },
            child: Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
