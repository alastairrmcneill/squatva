import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/services/services.dart';

class CurrentWorkoutOverlay extends StatelessWidget {
  const CurrentWorkoutOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    LogWorkoutBuilderNotifier logWorkoutBuilderNotifier =
        Provider.of<LogWorkoutBuilderNotifier>(context);

    if (!logWorkoutBuilderNotifier.inProgress) return const SizedBox(height: 10);

    int totalExercises = logWorkoutBuilderNotifier.getTotalExercises;
    int remainingExercises = logWorkoutBuilderNotifier.remainingExercises;

    double percentComplete = (totalExercises - remainingExercises) / totalExercises;
    if (totalExercises == 0) percentComplete = 0;

    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LogWorkoutScreen())),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Workout in progress',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '$remainingExercises set${remainingExercises == 1 ? '' : 's'} left',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  CircularPercentIndicator(
                    radius: 35,
                    percent: percentComplete,
                    progressColor: Theme.of(context).hintColor,
                    backgroundColor:
                        Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.2),
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      '${(percentComplete * 100).toStringAsFixed(0)}%',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
