import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipboard(
  String value, {
  required BuildContext context,
}) {
  setClipboardData(value);
  // final t = AppLocalizations.of(context);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Copiado al portapapeles"),
      duration: Duration(seconds: 2),
    ),
  );
}

void setClipboardData(String value) {
  Clipboard.setData(ClipboardData(text: value));
}
