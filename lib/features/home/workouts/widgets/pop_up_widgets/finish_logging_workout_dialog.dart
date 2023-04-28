import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinishLoggingWorkoutDialog extends StatelessWidget {
  const FinishLoggingWorkoutDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = 'Sorry, saving workouts hasn\'t been implemented yet. At the moment, I\'ve just focused on the workflow of recording a workout.';
    return Platform.isIOS ? _showIOSDialog(context, title: title) : _showAndroidDialog(context, title: title);
  }

  AlertDialog _showAndroidDialog(
    BuildContext context, {
    required String title,
  }) {
    return AlertDialog(
      title: Text(title),
      actions: [
        TextButton(
          child: const Text('Continue'),
          onPressed: () => Navigator.of(context).pop('Continue'),
        ),
      ],
    );
  }

  CupertinoAlertDialog _showIOSDialog(
    BuildContext context, {
    required String title,
  }) {
    return CupertinoAlertDialog(
      title: Text(title),
      actions: [
        CupertinoDialogAction(
          child: const Text('Continue'),
          onPressed: () => Navigator.of(context).pop('Continue'),
        ),
      ],
    );
  }
}

Future<String> showFinishLoggingWorkoutDialog(BuildContext context) async {
  String result = await showDialog(
    context: context,
    builder: (context) => FinishLoggingWorkoutDialog(),
  );
  return result;
}
