import 'package:flutter/material.dart';

class LocaleCodeAtom extends StatelessWidget {
  const LocaleCodeAtom(this.code, {super.key, this.textStyle});

  final String code;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      code.toUpperCase(),
      style: textStyle ??
          TextStyle(
            fontSize: theme.textTheme.bodyLarge?.fontSize,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
