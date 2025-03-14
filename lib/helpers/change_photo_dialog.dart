import 'dart:io';

import 'package:chat_app/global/chat_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

changePhotoDialog(BuildContext context, String title, File photo, void Function() onPressed) {
  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Image.file(photo),
        actions: [
          MaterialButton(
            elevation: 5,
            textColor: Theme.of(context).highlightColor,
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          MaterialButton(
            elevation: 5,
            textColor: Theme.of(context).highlightColor,
            onPressed: onPressed,
            child: const Text('Change'),
          )
        ],
      ),
    );
  }

  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(title),
      content: Card(
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        child: Image.file(photo)
      ),
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
            'Change',
            style: TextStyle(color: Theme.of(context).highlightColor),
          ),
        )
      ],
    ),
  );
}
