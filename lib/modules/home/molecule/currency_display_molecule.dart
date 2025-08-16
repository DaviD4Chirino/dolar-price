import 'package:awesome_dolar_price/extensions/double_extensions/sized_box_extension.dart';
import 'package:awesome_dolar_price/tokens/app/app_spacing.dart';
import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CurrencyToSymbolWidget(
              currencyCode: currency,
              textStyle: theme.textTheme.bodyLarge,
            ),
            AppSpacing.sm.sizedBoxW,
            Text(currency, style: theme.textTheme.bodyLarge)
          ],
        ),
        Text(value, style: theme.textTheme.bodyLarge),
      ],
    );
  }
}
