import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/models/models.dart';
import 'package:squatva/notifiers/notifiers.dart';
import 'package:squatva/screens/create_exercise_screen.dart';
import 'package:squatva/screens/exercise_detail_screen.dart';
import 'package:squatva/services/services.dart';
import 'package:squatva/widgets/filter_option_1.dart';
import 'package:squatva/widgets/filter_option_2.dart';
import 'package:squatva/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future _loadData() async {
    await UserDatabase.readCurrentUser(context);
    await ExerciseService.loadUserExercises(context);
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(userNotifier.currentUser?.name ?? "Loading"),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.signOut(context);
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            Filter1(),
            const SizedBox(height: 20),
            Filter2(),
            // ...exerciseNotifier.exerciseList.map((Exercise exercise) {
            //   return ListTile(
            //     title: Text(exercise.name),
            //     trailing: exercise.userID != null ? const Icon(Icons.check) : const SizedBox(),
            //     onTap: () => Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (_) => ExerciseDetailScreen(exercise: exercise),
            //       ),
            //     ),
            //   );
            // }).toList(),
            // ElevatedButton(
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (_) => CreateExerciseScreen()),
            //   ),
            //   child: const Text('Create'),
            // )
          ],
        ),
      ),
    );
  }
}
