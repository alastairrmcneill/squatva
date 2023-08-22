import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscardWorkoutPopup extends StatelessWidget {
  const DiscardWorkoutPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = 'Are you sure you want to discard this workout?';
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
          child: const Text('Discard'),
          onPressed: () => Navigator.of(context).pop('Discard'),
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
          child: const Text('Discard'),
          onPressed: () => Navigator.of(context).pop('Discard'),
        ),
        CupertinoDialogAction(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop('Cancel'),
        ),
      ],
    );
  }
}

Future<String> showDiscardWorkoutPopup(BuildContext context) async {
  String result = await showDialog(
    context: context,
    builder: (context) => DiscardWorkoutPopup(),
  );
  return result;
}
