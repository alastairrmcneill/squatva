import 'package:flutter/material.dart';

class EnableNotifier extends ChangeNotifier {
  bool signInEnabled = true;
  bool passwordRecoveryEnabled = true;
  bool registerEnabled = true;

  set setPasswordRecoveryEnabled(bool enabled) {
    passwordRecoveryEnabled = enabled;
  }

  set setRegisterEnabled(bool enabled) {
    registerEnabled = enabled;
  }

  set setSignInEnabled(bool enabled) {
    signInEnabled = enabled;
  }
}