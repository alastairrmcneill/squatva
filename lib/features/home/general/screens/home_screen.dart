import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/coach/screens/screens.dart';
import 'package:squatva/features/home/profile/screens/screens.dart';
import 'package:squatva/features/home/record/screens/screens.dart';
import 'package:squatva/features/home/social/screens/screens.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/services/services.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
  List<Widget> screens = const [
    SocialScreen(),
    WorkoutsScreen(),
    RecordScreen(),
    CoachScreen(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future _loadData() async {
    await UserDatabase.readCurrentUser(context);
    await ExerciseService.loadUserExercises(context);
    await WorkoutService.loadUserWorkoutTemplates(context);
    await WorkoutService.loadUserWorkouts(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) => setState(() => currentIndex = value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.create_rounded), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.radio_button_checked_rounded), label: 'Record'),
          BottomNavigationBarItem(icon: Icon(Icons.bus_alert), label: 'Coach'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
