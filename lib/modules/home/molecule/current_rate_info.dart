import 'package:awesome_dolar_price/modules/home/atoms/currency_comparison.dart';
import 'package:awesome_dolar_price/providers/currency_exchange_provider.dart';
import 'package:awesome_dolar_price/providers/main_currency_provider.dart';
import 'package:awesome_dolar_price/providers/translation.dart';
import 'package:awesome_dolar_price/tokens/models/currencies.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrentRateInfo extends ConsumerWidget {
  const CurrentRateInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);

    final locale = ref.watch(translationNotifierProvider);
    final quote = ref.watch(currencyExchangeNotifierProvider);
    final mainCurrency = ref.watch(mainCurrencyNotifierProvider);

    final lastUpdate = DateTime.parse(quote.lastUpdateTime)
        .format("EEEE, dd/MM/yyyy", locale.toLanguageTag())
        .capitalize;

    final lastRate = quote.lastQuote!.rates.getRate(
      mainCurrency,
    );
    final currentRate = quote.rates.getRate(mainCurrency);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (quote.lastQuote != null &&
                mainCurrency == Currencies.usd ||
            mainCurrency == Currencies.usdParallel)
          CurrencyComparison(
            lastRate: lastRate,
            currentRate: currentRate,
          ),
        /* Text(
          quote.lastQuote?.rates
                  .getRate(mainCurrency)
                  .toStringAsFixed(3) ??
              "0.0",
        ) */
        Expanded(
          child: Text(
            lastUpdate,
            textAlign: TextAlign.end,
            style: theme.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
