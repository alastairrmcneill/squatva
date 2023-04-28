import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/models/workout_template_model.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class WorkoutTemplateList extends StatelessWidget {
  final String title;
  final List<WorkoutTemplate> workoutTemplates;
  const WorkoutTemplateList({
    super.key,
    required this.title,
    required this.workoutTemplates,
  });

  @override
  Widget build(BuildContext context) {
    WorkoutTemplateNotifier workoutTemplateNotifier = Provider.of<WorkoutTemplateNotifier>(context);
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Container(
              height: 2,
              width: 80,
              color: Theme.of(context).accentColor,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 174,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(width: 8),
                ...workoutTemplates.map((workoutTemplate) {
                  return WorkoutTemplateTile(workoutTemplate: workoutTemplate);
                }).toList(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateWorkoutTemplateScreen())),
                    child: Center(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1),
                        foregroundColor: Theme.of(context).textTheme.bodyLarge!.color!,
                        child: const Icon(Icons.add_rounded),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
