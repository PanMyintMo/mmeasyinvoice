import 'package:flutter/material.dart';

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String confirmText,
  required Function onConfirm,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(content),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
            child: Text(confirmText),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("No"),
          ),
        ],
      );
    },
  );
}
