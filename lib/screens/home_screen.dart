import 'package:flutter/material.dart';
import 'package:squatva/services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: ElevatedButton(
          child: Text('Sign Out'),
          onPressed: () async {
            await AuthService.signOut();
          },
        ),
      ),
    );
  }
}
