// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/services/log_workout_builder_notifier.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';

import 'package:squatva/general/models/models.dart';

class WorkoutTemplateTile extends StatelessWidget {
  final WorkoutTemplate workoutTemplate;
  const WorkoutTemplateTile({
    Key? key,
    required this.workoutTemplate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogWorkoutBuilderNotifier logWorkoutBuilderNotifier = Provider.of<LogWorkoutBuilderNotifier>(context);
    double totalHeight = 170;
    double totalWidth = MediaQuery.of(context).size.width * 0.6;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: SizedBox(
        width: totalWidth,
        height: totalHeight,
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Column(
              children: [
                Container(
                  height: (totalHeight - 8) * 0.65,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workoutTemplate.name,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Created by: ',
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).textTheme.labelMedium!.color!.withOpacity(0.6),
                                    ),
                              ),
                              TextSpan(
                                text: 'Me',
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: Theme.of(context).textTheme.labelMedium!.color!.withOpacity(0.6),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  endIndent: 7,
                  indent: 7,
                ),
                Container(
                  height: (totalHeight - 8) * 0.35,
                  width: totalWidth,
                  padding: const EdgeInsets.only(bottom: 7, left: 7, right: 7),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: (totalWidth - 22) / 2,
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '10',
                                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).textTheme.labelMedium!.color!.withOpacity(0.6),
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'exercises',
                                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                          fontWeight: FontWeight.w300,
                                          color: Theme.of(context).textTheme.labelMedium!.color!.withOpacity(0.6),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const VerticalDivider(width: 0),
                        SizedBox(
                          height: double.infinity,
                          width: (totalWidth - 22) / 2,
                          child: TextButton(
                            onPressed: () async {
                              String action = 'New';
                              if (logWorkoutBuilderNotifier.inProgress) {
                                action = await showContinueLoggingWorkoutDialog(context);
                              }

                              if (action == 'New') {
                                logWorkoutBuilderNotifier.setInProgress = true;
                                logWorkoutBuilderNotifier.exerciseSets = [];
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const LogWorkoutScreen()));
                              } else if (action == 'Continue') {
                                logWorkoutBuilderNotifier.setInProgress = true;
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const LogWorkoutScreen()));
                              }
                            },
                            child: Text('Start'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
