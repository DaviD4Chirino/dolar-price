import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipboard(String value, {required BuildContext context}) {
  setClipboardData(value);
  final t = AppLocalizations.of(context);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(t.utilsCopyToClipboard),
      duration: Duration(seconds: 2),
    ),
  );
}

void setClipboardData(String value) {
  Clipboard.setData(ClipboardData(text: value));
}
