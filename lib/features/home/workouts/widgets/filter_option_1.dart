import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/screens/screens.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class Filter1 extends StatefulWidget {
  const Filter1({super.key});

  @override
  State<Filter1> createState() => _Filter1State();
}

class _Filter1State extends State<Filter1> {
  bool showAdvanced = false;

  @override
  Widget build(BuildContext context) {
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  isDense: true,
                ),
                onChanged: (value) {
                  exerciseNotifier.setFilterString(value);
                },
              ),
            ),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FilterScreen(
                    preSelectedEquipmentTags: exerciseNotifier.filterEquipmentTags,
                    preSelectedCategoryTags: exerciseNotifier.filterCategoryTags,
                    preSelectedLimbTags: exerciseNotifier.filterLimbTags,
                  ),
                ),
              ),
              icon: const Icon(
                Icons.filter_list_rounded,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
