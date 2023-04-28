import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/coach/screens/screens.dart';
import 'package:squatva/features/home/profile/screens/screens.dart';
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 25,
          left: 15,
          right: 15,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: GNav(
              backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
              color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
              activeColor: Colors.white,
              tabBackgroundColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
              tabMargin: const EdgeInsets.all(8),
              gap: 2,
              tabBorderRadius: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              selectedIndex: currentIndex,
              onTabChange: (value) => setState(() => currentIndex = value),
              duration: const Duration(milliseconds: 300),
              tabs: const [
                GButton(
                  icon: Icons.home_rounded,
                  text: 'Home',
                ),
                GButton(
                  icon: FontAwesomeIcons.dumbbell,
                  text: '   Workouts',
                ),
                GButton(
                  icon: FontAwesomeIcons.listCheck,
                  text: '  Coach',
                ),
                GButton(
                  icon: Icons.person_rounded,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
