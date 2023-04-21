import 'package:flutter/material.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/models/models.dart';

class SuperSetCard extends StatelessWidget {
  final int exerciseIndex;
  final Superset superset;
  const SuperSetCard({
    super.key,
    required this.exerciseIndex,
    required this.superset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        children: superset.exercises
            .map((exerciseSet) => ExerciseSetCard(
                  exerciseIndex: exerciseIndex,
                  exerciseSet: exerciseSet,
                ))
            .toList(),
      ),
    );
  }
}
