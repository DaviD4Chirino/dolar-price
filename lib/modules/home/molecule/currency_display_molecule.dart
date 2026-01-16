import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:flutter/material.dart';

class CurrencyDisplayMolecule extends StatelessWidget {
  const CurrencyDisplayMolecule({
    super.key,
    required this.currency,
    this.title,
    this.onTap,
  });

  final SupportedCurrency currency;
  final String? title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListTile(
      dense: true,
      onTap: onTap,

      title: Text(
        title ?? "${currency.symbol} ${currency.name}",
        style: theme.textTheme.bodyLarge,
      ),
      trailing: Text(
        currency.rate > 0.0
            ? currency.rate.toStringAsFixed(2)
            : currency.rate.toStringAsFixed(0),
        style: theme.textTheme.bodyLarge,
      ),
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
