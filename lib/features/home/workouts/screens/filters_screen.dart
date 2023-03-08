import 'package:flutter/material.dart';
import 'package:squatva/general/models/exercise_model.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: Equipment.all.map((e) => Text(e)).toList()),
    );
  }
}
