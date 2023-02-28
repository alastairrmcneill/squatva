import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/notifiers/enable_notifier.dart';
import 'package:squatva/services/services.dart';

class SignInButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const SignInButton({Key? key, required this.formKey, required this.emailController, required this.passwordController}) : super(key: key);

  Future _signIn(BuildContext context) async {
    await AuthService.signInWithEmail(
      context,
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: () async {
          EnableNotifier enableNotifier = Provider.of<EnableNotifier>(context, listen: false);
          if (!enableNotifier.signInEnabled) return;
          enableNotifier.setSignInEnabled = false;

          if (!formKey.currentState!.validate()) {
            return;
          }
          formKey.currentState!.save();
          await _signIn(context);

          enableNotifier.setSignInEnabled = true;
        },
        child: const Text('Sign In'),
      ),
    );
  }
}
