// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';

import 'package:squatva/general/models/models.dart';

class WorkoutTemplateDetailScreen extends StatelessWidget {
  final WorkoutTemplate workoutTemplate;
  const WorkoutTemplateDetailScreen({
    Key? key,
    required this.workoutTemplate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workoutTemplate.name),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert_rounded),
            onSelected: (value) async {
              if (value == WorkoutTemplateMenuItems.item1) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => CreateWorkoutTemplateScreen(workoutTemplate: workoutTemplate)));
              } else if (value == WorkoutTemplateMenuItems.item2) {
                showDialog(
                  context: context,
                  builder: (context) => DeleteWorkoutTemplatePopUp(workoutTemplate: workoutTemplate),
                );
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: WorkoutTemplateMenuItems.item1,
                child: Text('Edit'),
              ),
              PopupMenuItem(
                value: WorkoutTemplateMenuItems.item2,
                child: Text('Delete'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

enum WorkoutTemplateMenuItems {
  item1,
  item2;
}
