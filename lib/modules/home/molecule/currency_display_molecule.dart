import 'package:flutter/material.dart';

class CurrencyDisplayMolecule extends StatelessWidget {
  const CurrencyDisplayMolecule({
    super.key,
    required this.currency,
    required this.value,
  });

  final String currency;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          currency,
          style: theme.textTheme.bodyLarge,
        ),
        Text(value, style: theme.textTheme.bodyLarge),
      ],
    );
  }
}
