import 'package:flutter/material.dart';
import 'package:squatva/general/services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Logout'),
            onTap: () async {
              await AuthService.signOut(context);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Delete Account'),
            onTap: () async {
              await AuthService.delete(context);
            },
          )
        ],
      ),
    );
  }
}
