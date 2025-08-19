import 'package:awesome_dolar_price/providers/currency_exchange_provider.dart';
import 'package:awesome_dolar_price/providers/translation.dart';
import 'package:awesome_dolar_price/tokens/app/app_spacing.dart';
import 'package:awesome_dolar_price/tokens/utils/helpers/percentage_calculator.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrencyDisplay extends ConsumerWidget {
  const CurrencyDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dolarPriceProvider =
        ref.watch(currencyExchangeNotifierProvider);
    final locale = ref.watch(translationNotifierProvider);

    final ThemeData theme = Theme.of(context);
    final lastUpdate =
        DateTime.parse(dolarPriceProvider.lastUpdateTime)
            .format(
              "EEEE, dd/MM/yyyy",
              locale.toLanguageTag(),
            )
            .capitalize;
    final growth = percentageChange(
      dolarPriceProvider.lastQuote?.rates.usd ?? 0,
      dolarPriceProvider.rates.usd,
    ).toStringAsFixed(1);

    final amountChanged = (dolarPriceProvider.rates.usd -
            (dolarPriceProvider.lastQuote?.rates.usd ?? 0))
        .toStringAsFixed(2);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.all(
              Radius.circular(AppSpacing.lg),
            ),
          ),
          // height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.md),
            child: Text(
              "${dolarPriceProvider.rates.usd.toStringAsFixed(3)} Bs",
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$amountChanged ($growth%)",
              textAlign: TextAlign.end,
            ),
            Text(
              lastUpdate,
              textAlign: TextAlign.end,
            ),
          ],
        ),
        // Add a percentage comparing this price and the previous one
      ],
    );
  }
}
