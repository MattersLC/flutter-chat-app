import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:chat_app/global/chat_colors.dart';

showAlert(BuildContext context, String title, String subtitle) {
  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: ChatColors.primaryLight,
        title: Text(title),
        content: Text(subtitle),
        actions: [
          MaterialButton(
            elevation: 5,
            textColor: ChatColors.contrast,
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }

  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Ok',
            style: TextStyle(color: ChatColors.contrast),
          ),
        )
      ],
    ),
  );
}
