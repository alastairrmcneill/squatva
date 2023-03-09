import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

class FilterScreen extends StatefulWidget {
  final List<String> preSelectedEquipmentTags;
  final List<String> preSelectedCategoryTags;
  final List<String> preSelectedLimbTags;

  const FilterScreen({super.key, required this.preSelectedEquipmentTags, required this.preSelectedCategoryTags, required this.preSelectedLimbTags});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late List<String> selectedEquipmentTags;
  late List<String> selectedCategoryTags;
  late List<String> selectedLimbTags;
  @override
  void initState() {
    super.initState();
    selectedEquipmentTags = widget.preSelectedEquipmentTags;
    selectedCategoryTags = widget.preSelectedCategoryTags;
    selectedLimbTags = widget.preSelectedLimbTags;
  }

  @override
  Widget build(BuildContext context) {
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            exerciseNotifier.setFilterTags(
              equipmentTags: selectedEquipmentTags,
              categoryTags: selectedCategoryTags,
              limbTags: selectedLimbTags,
            );
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              exerciseNotifier.setFilterTags(
                equipmentTags: selectedEquipmentTags,
                categoryTags: selectedCategoryTags,
                limbTags: selectedLimbTags,
              );
              Navigator.pop(context);
            },
            child: Text(
              'Filter',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Equipment'),
          Wrap(
            children: Equipment.all
                .map(
                  (equipment) => SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Row(
                      children: [
                        Checkbox(
                          value: selectedEquipmentTags.contains(equipment),
                          onChanged: (isChecked) => setState(() {
                            if (isChecked!) {
                              selectedEquipmentTags.add(equipment);
                            } else {
                              selectedEquipmentTags.remove(equipment);
                            }
                          }),
                        ),
                        Text(equipment),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          Divider(),
          Text('Category'),
          Wrap(
            children: ExerciseCategory.all
                .map(
                  (category) => SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Row(
                      children: [
                        Checkbox(
                          value: selectedCategoryTags.contains(category),
                          onChanged: (isChecked) => setState(() {
                            if (isChecked!) {
                              selectedCategoryTags.add(category);
                            } else {
                              selectedCategoryTags.remove(category);
                            }
                          }),
                        ),
                        Text(category),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          Divider(),
          Text('Limb Involvement'),
          Wrap(
            children: LimbInvolvement.all
                .map(
                  (limbs) => SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Row(
                      children: [
                        Checkbox(
                          value: selectedLimbTags.contains(limbs),
                          onChanged: (isChecked) => setState(() {
                            if (isChecked!) {
                              selectedLimbTags.add(limbs);
                            } else {
                              selectedLimbTags.remove(limbs);
                            }
                          }),
                        ),
                        Text(limbs),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
