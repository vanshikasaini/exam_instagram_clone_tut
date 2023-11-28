import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

@immutable
class AlertDialogModel<T> {
  final String title;
  final String message;

  /// T --> generic or dynamic payload
  final Map<String, T> buttons;
  const AlertDialogModel({
    required this.title,
    required this.message,
    required this.buttons,
  });
}
// presentation layer  of AlertDialog

extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: buttons.entries.map((entry) {
            return TextButton(
              onPressed: () {
                Navigator.of(context).pop(entry.value);
              },
              child: Text(entry.key),
            );
          }).toList(),
        );
      },
    );
  }
}
