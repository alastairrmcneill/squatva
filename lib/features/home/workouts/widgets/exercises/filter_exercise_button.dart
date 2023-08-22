// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class FilterExerciseButton extends StatelessWidget {
  final String title;
  final List<String> filterOptions;
  final List<String> preSelectedTags;
  final bool selected;
  const FilterExerciseButton({
    Key? key,
    required this.title,
    required this.filterOptions,
    required this.preSelectedTags,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context);
    return ElevatedButton(
      onPressed: () {
        showFilterBottomSheet(
          context,
          exerciseNotifier,
          title: title,
          filterOptions: filterOptions,
          selectedTags: preSelectedTags,
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color?>(
            selected ? Theme.of(context).hintColor : Colors.white),
        foregroundColor: MaterialStateProperty.all<Color?>(
            selected ? Colors.white : Color(0xFF616161)),
        side: MaterialStateProperty.all<BorderSide?>(
          BorderSide(
              color: selected ? Colors.transparent : const Color(0xFF616161), width: 0.5),
        ),
      ),
      child: Text(title),
    );
  }
}
