import 'package:dart_date/dart_date.dart';
import 'package:doya/providers/currency_exchange_provider.dart';
import 'package:doya/providers/main_currency_provider.dart';
import 'package:doya/tokens/extensions/string/capitalize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrentRateInfo extends ConsumerWidget {
  const CurrentRateInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);

    // final locale = ref.watch(translationProvider);
    final quote = ref.watch(currencyExchangeProvider);
    final mainCurrency = ref.watch(mainCurrencyProvider);

    final lastUpdate = handleDate(quote.lastUpdateTime);

    final nextUpdate = handleDate(quote.nextUpdateTime);

    final currentRate = quote.rates.rates[mainCurrency.code];

    if (currentRate == null) {
      return Container();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /*   if (quote.lastQuote != null &&
                mainCurrency.code == Currencies.usd ||
            mainCurrency.code == Currencies.usdParallel)
          CurrencyComparison(
            lastRate:
                quote.lastQuote?.rates.getRate(
                  mainCurrency.code,
                ) ??
                0.0,
            currentRate: currentRate.rate,
          ), */
        /* Text(
          quote.lastQuote?.rates
                  .getRate(mainCurrency.code)
                  .toStringAsFixed(3) ??
              "0.0",
        ), */
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

  String handleDate(int millisecondsSinceEpoch) {
    return DateTime.fromMillisecondsSinceEpoch(
      millisecondsSinceEpoch,
    ).format("EEEE, dd MMMM.", "es").capitalize();
  }
}
