import 'package:flutter/material.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/models/models.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final Exercise exercise;
  const ExerciseDetailScreen({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
        actions: [
          exercise.userID != null
              ? PopupMenuButton(
                  icon: Icon(Icons.more_vert_rounded),
                  onSelected: (value) async {
                    if (value == ExerciseMenuItems.item1) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => CreateExerciseScreen(exercise: exercise)));
                    } else if (value == ExerciseMenuItems.item2) {
                      showDialog(
                        context: context,
                        builder: (context) => DeleteExercisePopUp(exercise: exercise),
                      );
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: ExerciseMenuItems.item1,
                      child: Text('Edit'),
                    ),
                    PopupMenuItem(
                      value: ExerciseMenuItems.item2,
                      child: Text('Delete'),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
      body: Center(
        child: Text(
          '''ExerciseDetail\n\n This is where you can find stats, notes etc. on the exercise. ''',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

enum ExerciseMenuItems {
  item1,
  item2;
}
