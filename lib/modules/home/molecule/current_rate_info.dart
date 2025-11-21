import 'package:doya/modules/home/atoms/currency_comparison.dart';
import 'package:doya/providers/currency_exchange_provider.dart';
import 'package:doya/providers/main_currency_provider.dart';
import 'package:doya/providers/translation.dart';
import 'package:doya/tokens/models/currencies.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrentRateInfo extends ConsumerWidget {
  const CurrentRateInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);

    final locale = ref.watch(translationProvider);
    final quote = ref.watch(currencyExchangeProvider);
    final mainCurrency = ref.watch(mainCurrencyProvider);

    final lastUpdate = DateTime.parse(quote.lastUpdateTime)
        .format("EEEE, dd MMM. h:mm a", locale.toLanguageTag())
        .capitalize;
    final nextUpdate = DateTime.parse(quote.nextUpdateTime)
        .format(
          "EEEE, dd MMM. yyyy h:mm a",
          locale.toLanguageTag(),
        )
        .capitalize;

    final currentRate = quote.rates.getRate(mainCurrency);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (quote.lastQuote != null &&
                mainCurrency == Currencies.usd ||
            mainCurrency == Currencies.usdParallel)
          CurrencyComparison(
            lastRate:
                quote.lastQuote?.rates.getRate(mainCurrency) ??
                0.0,
            currentRate: currentRate,
          ),
        /* Text(
          quote.lastQuote?.rates
                  .getRate(mainCurrency)
                  .toStringAsFixed(3) ??
              "0.0",
        ) */
        Expanded(
          child: Tooltip(
            message: 'Siguiente actualización:\n$nextUpdate',
            child: Text(
              lastUpdate,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ),
      ],
    );
  }
}
