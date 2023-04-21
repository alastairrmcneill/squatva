import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/profile/screens/screens.dart';
import 'package:squatva/general/notifiers/notifiers.dart';
import 'package:squatva/general/services/services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WorkoutNotifier workoutNotifier = Provider.of<WorkoutNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('You'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            'Profile Tab\n\nCheck out your own personal history, stats, settings etc.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
