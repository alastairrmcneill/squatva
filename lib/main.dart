import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/services/services.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

import 'package:squatva/general/services/services.dart';
import 'package:squatva/support/theme.dart';
import 'package:squatva/support/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: AuthService.appUserStream,
          initialData: null,
        ),
        ChangeNotifierProvider<EnableNotifier>(
          create: (_) => EnableNotifier(),
        ),
        ChangeNotifierProvider<UserNotifier>(
          create: (_) => UserNotifier(),
        ),
        ChangeNotifierProvider<ExerciseNotifier>(
          create: (_) => ExerciseNotifier(),
        ),
        ChangeNotifierProvider<WorkoutTemplateBuilderNotifier>(
          create: (_) => WorkoutTemplateBuilderNotifier(),
        ),
        ChangeNotifierProvider<WorkoutTemplateNotifier>(
          create: (_) => WorkoutTemplateNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'Squatva',
        theme: MyThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
      ),
    );
  }
}
