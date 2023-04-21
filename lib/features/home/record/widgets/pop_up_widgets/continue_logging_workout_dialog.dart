import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContinueLoggingWorkoutDialog extends StatelessWidget {
  const ContinueLoggingWorkoutDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = 'You have already started a workout. Do you want to start a new one or continue';
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
        TextButton(
          child: const Text('Start New'),
          onPressed: () => Navigator.of(context).pop('New'),
        ),
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop('Cancel'),
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
        CupertinoDialogAction(
          child: const Text('Start New'),
          onPressed: () => Navigator.of(context).pop('New'),
        ),
        CupertinoDialogAction(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop('Cancel'),
        ),
      ],
    );
  }
}

Future<String> showContinueLoggingWorkoutDialog(BuildContext context) async {
  String result = await showDialog(
    context: context,
    builder: (context) => ContinueLoggingWorkoutDialog(),
  );
  return result;
}
