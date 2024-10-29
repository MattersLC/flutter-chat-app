import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showActionAlert(BuildContext context, String title, String textButton,
    Color colorButton, Function() onPressed) {
  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        actions: [
          MaterialButton(
            elevation: 5,
            textColor: Theme.of(context).highlightColor,
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          MaterialButton(
            elevation: 5,
            textColor: colorButton,
            onPressed: onPressed,
            child: Text(textButton),
          )
        ],
      ),
    );
  }

  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(title),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(color: Theme.of(context).highlightColor),
          ),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: onPressed,
          child: Text(
            textButton,
            style: TextStyle(color: colorButton),
          ),
        )
      ],
    ),
  );
}
