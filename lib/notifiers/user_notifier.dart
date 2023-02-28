import 'package:flutter/material.dart';
import 'package:squatva/models/models.dart';

class UserNotifier extends ChangeNotifier {
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;

  set setCurrentUser(AppUser? appUser) {
    _currentUser = appUser;
    notifyListeners();
  }
}
