// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/general/notifiers/workout_template_builder_notifier.dart';

class SetRow extends StatelessWidget {
  final String exerciseIndex;
  final int setNumber;
  final int reps;
  final double weight;
  late TextEditingController repsContorller;
  late TextEditingController weightController;
  SetRow({
    Key? key,
    required this.exerciseIndex,
    required this.setNumber,
    required this.reps,
    required this.weight,
  }) {
    repsContorller = TextEditingController(text: reps.toString());
    weightController = TextEditingController(text: weight.toString());
  }

  @override
  Widget build(BuildContext context) {
    WorkoutTemplateBuilderNotifier workoutTemplateBuilderNotifier = Provider.of<WorkoutTemplateBuilderNotifier>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 20),
        SizedBox(width: 30, child: Center(child: Text((setNumber + 1).toString()))),
        SizedBox(
            width: 90,
            child: Center(
                child: TextField(
              controller: repsContorller,
              decoration: InputDecoration(hintText: '-'),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  int _reps = int.parse(value);

                  workoutTemplateBuilderNotifier.exerciseSets[exerciseIndex]['sets'][setNumber]['reps'] = _reps;
                }
              },
            ))),
        SizedBox(
            width: 90,
            child: Center(
                child: TextField(
              controller: weightController,
              decoration: InputDecoration(hintText: '-'),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  double _weight = double.parse(value);

                  workoutTemplateBuilderNotifier.exerciseSets[exerciseIndex]['sets'][setNumber]['weight'] = _weight;
                }
              },
            ))),
      ],
    );
  }
}
