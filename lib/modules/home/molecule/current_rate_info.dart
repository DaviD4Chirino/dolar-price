import 'package:awesome_dolar_price/extensions/double_extensions/sized_box_extension.dart';
import 'package:awesome_dolar_price/modules/home/atoms/currency_comparison.dart';
import 'package:awesome_dolar_price/providers/currency_exchange_provider.dart';
import 'package:awesome_dolar_price/providers/translation.dart';
import 'package:awesome_dolar_price/tokens/app/app_spacing.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrentRateInfo extends ConsumerWidget {
  const CurrentRateInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final quote = ref.watch(currencyExchangeNotifierProvider);
    final locale = ref.watch(translationNotifierProvider);

    final lastUpdate = DateTime.parse(
      quote.lastUpdateTime,
    ).format("EEEE, dd/MM/yyyy", locale.toLanguageTag()).capitalize;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          // height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.sm,
            ),
            child: Text(
              "${quote.rates.usd.toStringAsFixed(3)} Bs",
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        AppSpacing.sm.sizedBoxH,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (quote.lastQuote != null)
              CurrencyComparison(
                lastRate: quote.lastQuote!.rates.usd,
                currentRate: quote.rates.usd,
              ),
            Text(lastUpdate, textAlign: TextAlign.end),
          ],
        ),
        // Add a percentage comparing this price and the previous one
      ],
    );
  }
}
