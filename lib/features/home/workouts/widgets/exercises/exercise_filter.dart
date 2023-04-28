import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:squatva/features/home/workouts/widgets/widgets.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class ExerciseFilter extends StatefulWidget {
  const ExerciseFilter({super.key});

  @override
  State<ExerciseFilter> createState() => _Filter1State();
}

class _Filter1State extends State<ExerciseFilter> {
  final TextEditingController textEditingController = TextEditingController();
  bool showAdvanced = false;

  @override
  Widget build(BuildContext context) {
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                        suffixIcon: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              textEditingController.text.isNotEmpty
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
                              VerticalDivider(),
                              IconButton(
                                onPressed: () => setState(() => showAdvanced = !showAdvanced),
                                icon: Icon(
                                  FontAwesomeIcons.sliders,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ],
                          ),
                        )),
                    onChanged: (value) {
                      exerciseNotifier.setFilterString(value);
                    },
                  ),
                ),
              ],
            ),
            showAdvanced
                ? Column(
                    children: [
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 50,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              FilterExerciseButton(
                                title: 'Equipment',
                                filterOptions: Equipment.all,
                                preSelectedTags: exerciseNotifier.filterEquipmentTags,
                                selected: exerciseNotifier.filterEquipmentTags.isNotEmpty,
                              ),
                              const SizedBox(width: 5),
                              FilterExerciseButton(
                                title: 'Category',
                                filterOptions: ExerciseCategory.all,
                                preSelectedTags: exerciseNotifier.filterCategoryTags,
                                selected: exerciseNotifier.filterCategoryTags.isNotEmpty,
                              ),
                              const SizedBox(width: 5),
                              FilterExerciseButton(
                                title: 'Limb Involvement',
                                filterOptions: LimbInvolvement.all,
                                preSelectedTags: exerciseNotifier.filterLimbTags,
                                selected: exerciseNotifier.filterLimbTags.isNotEmpty,
                              ),
                              const SizedBox(width: 5),
                              ElevatedButton(
                                onPressed: () {
                                  exerciseNotifier.setFilterTags(equipmentTags: [], categoryTags: [], limbTags: []);
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color?>(Colors.grey[400]),
                                  side: MaterialStateProperty.all<BorderSide?>(
                                    BorderSide(color: const Color(0xFF616161), width: 0.5),
                                  ),
                                ),
                                child: Text('Clear'),
                              ),
                            ],
                          ),
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
