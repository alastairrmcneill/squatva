import 'package:flutter/material.dart';
import 'package:squatva/general/notifiers/notifiers.dart';

showFilterBottomSheet(BuildContext context, ExerciseNotifier exerciseNotifier, {required String title, required List<String> filterOptions, required List<String> selectedTags}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
    builder: (context) => StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: const EdgeInsets.all(10),
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                decoration: TextDecoration.underline,
                decorationThickness: 0.5,
              ),
            ),
            Wrap(
              children: filterOptions
                  .map(
                    (equipment) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        children: [
                          Checkbox(
                            value: selectedTags.contains(equipment),
                            onChanged: (isChecked) => setState(() {
                              if (isChecked!) {
                                selectedTags.add(equipment);
                              } else {
                                selectedTags.remove(equipment);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      selectedTags = [];
                      Navigator.pop(context);
                    },
                    child: const Text('Clear'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Filter'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }),
  ).whenComplete(() {
    exerciseNotifier.setFilterTags(
      equipmentTags: title == 'Equipment' ? selectedTags : null,
      categoryTags: title == "Category" ? selectedTags : null,
      limbTags: title == 'Limb Involvement' ? selectedTags : null,
    );
  });
}
