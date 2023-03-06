import 'package:flutter/material.dart';
import 'package:squatva/models/exercise_model.dart';
import 'package:squatva/services/exercise_service.dart';

class CreateExerciseScreen extends StatefulWidget {
  final Exercise? exercise;
  CreateExerciseScreen({super.key, this.exercise});

  @override
  State<CreateExerciseScreen> createState() => _CreateExerciseScreenState();
}

class _CreateExerciseScreenState extends State<CreateExerciseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _linkTextEditingController = TextEditingController();
  final TextEditingController _noteTextEditingController = TextEditingController();
  final TextEditingController _tagsTextEditingController = TextEditingController();
  final List<String> equipmentList = Equipment.all;
  String? selectedEquipment;
  final List<String> categoryList = ExerciseCategory.all;
  String? selectedCategory;
  final List<String> limbList = LimbInvolvement.all;
  String? selectedLimb;
  bool expanded = false;
  late String nameString;

  @override
  void initState() {
    super.initState();

    if (widget.exercise != null) {
      Exercise exercise = widget.exercise!;
      _nameTextEditingController.text = exercise.name;
      selectedEquipment = exercise.equipment;
      selectedCategory = exercise.exerciseCategory == "" ? null : exercise.exerciseCategory;
      selectedLimb = exercise.limbInvolvement == "" ? null : exercise.limbInvolvement;

      if (exercise.tags.isNotEmpty) _tagsTextEditingController.text = exercise.tags.join(", ");

      if (exercise.link.isNotEmpty) _linkTextEditingController.text = exercise.link;
      if (exercise.note.isNotEmpty) _noteTextEditingController.text = exercise.note;
    }
  }

  Widget _buildNameFormField() {
    return TextFormField(
      controller: _nameTextEditingController,
      maxLines: 1,
      decoration: InputDecoration(hintText: 'Name'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
      },
      onSaved: (value) {
        _nameTextEditingController.text = value!;
      },
    );
  }

  Widget _buildEquipmentDropdown() {
    return DropdownButtonFormField<String>(
      hint: const Text('Equipment'),
      value: selectedEquipment,
      items: equipmentList
          .map(
            (equiment) => DropdownMenuItem<String>(
              value: equiment,
              child: Text(equiment),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedEquipment = value as String;
        });
      },
      validator: (value) {
        if (selectedEquipment == null) {
          return 'Required';
        }
        return null;
      },
    );
  }

  Widget _buildAdvancedButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: Row(
        children: [
          const Text('Advanced'),
          Icon(expanded ? Icons.arrow_drop_down_sharp : Icons.arrow_right_sharp),
        ],
      ),
    );
  }

  Widget _buildAdvancedFormSection() {
    return Column(
      children: [
        _buildCategoryDropdown(),
        _buildLimbDropdown(),
        _buildTagsFormField(),
        _buildLinkFormField(),
        _buildNoteFormField(),
      ],
    );
  }

  Widget _buildLinkFormField() {
    return TextFormField(
      controller: _linkTextEditingController,
      maxLines: 1,
      decoration: const InputDecoration(hintText: 'Link'),
      onSaved: (value) {
        _linkTextEditingController.text = value ?? '';
      },
    );
  }

  Widget _buildNoteFormField() {
    return TextFormField(
      controller: _noteTextEditingController,
      decoration: const InputDecoration(hintText: 'Note'),
      onSaved: (value) {
        _noteTextEditingController.text = value ?? '';
      },
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      hint: const Text('Category'),
      value: selectedCategory,
      items: categoryList
          .map(
            (category) => DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCategory = value as String;
        });
      },
    );
  }

  Widget _buildLimbDropdown() {
    return DropdownButtonFormField<String>(
      hint: const Text('Limb involvment'),
      value: selectedLimb,
      items: limbList
          .map(
            (limb) => DropdownMenuItem<String>(
              value: limb,
              child: Text(limb),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedLimb = value as String;
        });
      },
    );
  }

  Widget _buildTagsFormField() {
    return TextFormField(
      controller: _tagsTextEditingController,
      maxLines: 1,
      decoration: const InputDecoration(hintText: 'Tags (separate by , )'),
      onSaved: (value) {
        _tagsTextEditingController.text = value ?? '';
      },
    );
  }

  _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (widget.exercise == null) {
      Exercise exercise = Exercise(
        name: _nameTextEditingController.text.trim(),
        exerciseCategory: selectedCategory ?? ExerciseCategory.other,
        limbInvolvement: selectedLimb ?? LimbInvolvement.bilateral,
        equipment: selectedEquipment ?? Equipment.other,
        bodyParts: [],
        tags: _tagsTextEditingController.text.trim().split(','),
        link: _linkTextEditingController.text.trim(),
        note: _noteTextEditingController.text.trim(),
      );
      await ExerciseService.create(context, exercise: exercise);
    } else {
      Exercise newExercise = widget.exercise!.copy(
        name: _nameTextEditingController.text.trim(),
        exerciseCategory: selectedCategory ?? ExerciseCategory.other,
        limbInvolvement: selectedLimb ?? LimbInvolvement.bilateral,
        equipment: selectedEquipment ?? Equipment.other,
        bodyParts: [],
        tags: _tagsTextEditingController.text.trim().split(','),
        link: _linkTextEditingController.text.trim(),
        note: _noteTextEditingController.text.trim(),
      );

      await ExerciseService.updateExercise(context, newExercise: newExercise);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise == null ? 'Create Exercise' : 'Edit Exercise'),
        actions: [
          TextButton(
            onPressed: () async {
              await _submit();
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildNameFormField(),
              _buildEquipmentDropdown(),
              _buildAdvancedButton(),
              expanded ? _buildAdvancedFormSection() : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
