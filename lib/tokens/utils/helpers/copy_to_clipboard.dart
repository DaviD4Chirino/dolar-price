import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipboard(
  String value, {
  required BuildContext context,
}) {
  setClipboardData(value);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "Copied to clipboard",
      ),
      duration: Duration(seconds: 2),
    ),
  );
}

void setClipboardData(String value) {
  Clipboard.setData(
    ClipboardData(text: value),
  );
}
