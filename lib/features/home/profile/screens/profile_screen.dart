import 'package:flutter/material.dart';
import 'package:squatva/general/services/services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('''This is where we will build out the user profile where they can see their stats, workout activity, previous workouts, settings etc.'''),
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
