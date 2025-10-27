import 'package:doya/extensions/double_extensions/sized_box_extension.dart';
import 'package:doya/modules/home/atoms/copy_button.dart';
import 'package:doya/providers/currency_exchange_provider.dart';
import 'package:doya/providers/main_currency_provider.dart';
import 'package:doya/tokens/app/app_sizing.dart';
import 'package:doya/tokens/app/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Big ass price title
class CurrencyValueTitle extends ConsumerWidget {
  const CurrencyValueTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final mainCurrency = ref.watch(mainCurrencyProvider);

    final quote = ref.watch(currencyExchangeProvider);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      height: 65,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.sm,
            ),
            child: AppSizing.lg.sizedBoxH,
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "${quote.rates.getRate(mainCurrency).toStringAsFixed(3)}Bs",
                style: theme.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight.add(
                Alignment(-0.05, 0),
              ),
              child: CopyButton(
                value: quote.rates.allRates[mainCurrency] ?? 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
