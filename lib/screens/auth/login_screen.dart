import 'package:flutter/material.dart';
import 'package:squatva/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Sign In'),
          onPressed: () async {
            await AuthService.signInWithEmail(context, email: 'test@test.com', password: '123456');
          },
        ),
      ),
    );
  }
}
