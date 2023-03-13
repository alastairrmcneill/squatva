import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class Filter1 extends StatefulWidget {
  const Filter1({super.key});

  @override
  State<Filter1> createState() => _Filter1State();
}

class _Filter1State extends State<Filter1> {
  final TextEditingController textEditingController = TextEditingController();
  bool showAdvanced = false;

  @override
  Widget build(BuildContext context) {
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: SizedBox(
        height: showAdvanced ? 110 : 55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      isDense: true,
                      suffixIcon: textEditingController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                textEditingController.clear();
                                exerciseNotifier.setFilterString("");
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.grey,
                              ),
                            )
                          : const SizedBox(),
                    ),
                    onChanged: (value) {
                      exerciseNotifier.setFilterString(value);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => showAdvanced = !showAdvanced),
                  // onPressed: () => Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => FilterScreen(
                  //       preSelectedEquipmentTags: exerciseNotifier.filterEquipmentTags,
                  //       preSelectedCategoryTags: exerciseNotifier.filterCategoryTags,
                  //       preSelectedLimbTags: exerciseNotifier.filterLimbTags,
                  //     ),
                  //   ),
                  // ),
                  icon: const Icon(
                    Icons.filter_list_rounded,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            showAdvanced
                ? Column(
                    children: [
                      const SizedBox(height: 5),
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FilterExerciseButton(
                              title: 'Equipment',
                              filterOptions: Equipment.all,
                              preSelectedTags: exerciseNotifier.filterEquipmentTags,
                              selected: exerciseNotifier.filterEquipmentTags.isNotEmpty,
                            ),
                            FilterExerciseButton(
                              title: 'Category',
                              filterOptions: ExerciseCategory.all,
                              preSelectedTags: exerciseNotifier.filterCategoryTags,
                              selected: exerciseNotifier.filterCategoryTags.isNotEmpty,
                            ),
                            FilterExerciseButton(
                              title: 'Limb Involvement',
                              filterOptions: LimbInvolvement.all,
                              preSelectedTags: exerciseNotifier.filterLimbTags,
                              selected: exerciseNotifier.filterLimbTags.isNotEmpty,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
