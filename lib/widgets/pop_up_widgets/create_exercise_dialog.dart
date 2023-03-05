import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squatva/models/models.dart';
import 'package:squatva/notifiers/exercise_notifier.dart';
import 'package:squatva/services/services.dart';

class CreateExerciseDialog extends StatefulWidget {
  const CreateExerciseDialog({super.key});

  @override
  State<CreateExerciseDialog> createState() => _CreateExerciseDialogState();
}

class _CreateExerciseDialogState extends State<CreateExerciseDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _notesTextEditingController = TextEditingController();

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
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();

              await ExerciseService.create(context,
                  exercise: Exercise(
                    name: _nameTextEditingController.text,
                    exerciseCategory: ExerciseCategory.arms,
                    limbInvolvement: LimbInvolvement.bilateral,
                    equipment: Equipment.barbell,
                    bodyParts: ['Arms'],
                    tags: ['Strength'],
                    note: _notesTextEditingController.text,
                    userID: AuthService.currentUserId,
                  ));
              Navigator.pop(context);
            },
            child: Text('Create')),
      ],
    );
  }
}
