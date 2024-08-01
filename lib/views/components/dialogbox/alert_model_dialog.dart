import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class AlertDialogModel<T> {
  final String title;
  final String message;
  final Map<String, T> button;

  const AlertDialogModel({
    required this.title,
    required this.message,
    required this.button,
  });
}

extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: button.entries.map((entry) {
              return TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(entry.value);
                  },
                  child: Text(
                    entry.key,
                  ));
            }).toList(),
          );
        } else {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: button.entries.map((entry) {
              return TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(entry.value);
                  },
                  child: Text(
                    entry.key,
                  ));
            }).toList(),
          );
        }
      },
    );
  }
}
