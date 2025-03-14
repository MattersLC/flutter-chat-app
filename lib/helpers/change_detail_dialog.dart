import 'dart:io';

import 'package:chat_app/global/chat_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

changeDetailDialog(BuildContext context, String title, TextEditingController value, void Function() onPressed) {
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
        child: TextField(
          controller: value,
          decoration: InputDecoration(
            filled: true,
            //fillColor: Theme.of(context).secondaryHeaderColor,
            /*prefixIcon: const Icon(
              Icons.search,
              color: ChatColors.grayLight,
            ),*/
            //hintText: value,
            labelStyle: const TextStyle(color: ChatColors.grayLight),
            /*border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 12.0,
            ),*/
          ),
        ),
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
