import 'package:doya/tokens/models/currencies.dart';
import 'package:flutter/material.dart';

class CurrencyDisplayMolecule extends StatelessWidget {
  const CurrencyDisplayMolecule({
    super.key,
    required this.currency,
    required this.value,
    this.title,
    this.onTap,
  });

  final String currency;
  final String value;
  final String? title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListTile(
      dense: true,
      onTap: onTap,
      title: Text(
        title ??
            Currencies.getCurrencyTitle(
              currency,
              context: context,
            ),
        style: theme.textTheme.bodyLarge,
      ),
      trailing: Text(value, style: theme.textTheme.bodyLarge),
    );

    /* Row(
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
            Text(title ?? currency, style: theme.textTheme.bodyLarge),
          ],
        ),
        Text(value, style: theme.textTheme.bodyLarge),
      ],
    ); */
  }
}
