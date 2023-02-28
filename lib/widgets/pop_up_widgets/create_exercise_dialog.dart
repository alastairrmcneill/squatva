import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/models/exercise_model.dart';
import 'package:squatva/models/muscle_group_model.dart';
import 'package:squatva/notifiers/exercise_notifier.dart';

class CreateExerciseDialog extends StatefulWidget {
  const CreateExerciseDialog({super.key});

  @override
  State<CreateExerciseDialog> createState() => _CreateExerciseDialogState();
}

class _CreateExerciseDialogState extends State<CreateExerciseDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _notesTextEditingController = TextEditingController();
  MuscleGroup? muscleGroupSelected;

  Widget _buildDropDownFormField() {
    return DropdownButtonFormField<MuscleGroup>(
      decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 10)),
      isDense: false,
      value: muscleGroupSelected,
      items: muscleGroups
          .map(
            (muscleGroup) => DropdownMenuItem(
              value: muscleGroup,
              child: Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset(muscleGroup.imagePath),
                  ),
                  Text(muscleGroup.name),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          muscleGroupSelected = value;
        });
      },
      hint: const Text('Choose a muscle group'),
      validator: (value) {
        if (value == null) {
          return 'Required';
        }
      },
    );
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

  Widget _buildNotesFormField() {
    return TextFormField(
      controller: _notesTextEditingController,
      decoration: InputDecoration(hintText: 'Notes (optional)'),
      onSaved: (value) {
        _notesTextEditingController.text = value ?? '';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context, listen: false);
    return AlertDialog(
      title: const Text('Create new exercise:'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNameFormField(),
            _buildDropDownFormField(),
            _buildNotesFormField(),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        TextButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();

              exerciseNotifier.addExercise = Exercise(
                id: '1000',
                name: _nameTextEditingController.text,
                note: _notesTextEditingController.text,
                userMade: true,
                muscleGroupID: muscleGroupSelected!.id,
                exerciseType: ExerciseType.strength,
              );
              Navigator.pop(context);
            },
            child: Text('Create')),
      ],
    );
  }
}
