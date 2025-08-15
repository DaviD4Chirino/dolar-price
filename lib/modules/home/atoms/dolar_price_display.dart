import 'package:awesome_dolar_price/providers/dolar_price.dart';
import 'package:awesome_dolar_price/tokens/app/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DolarPriceDisplay extends ConsumerWidget {
  const DolarPriceDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dolarPriceProvider = ref.watch(dolarPriceNotifierProvider);

    final ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.all(
              Radius.circular(AppSpacing.lg),
            ),
          ),
          // height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Text(
              "${dolarPriceProvider.rates.usd.toStringAsFixed(3)} Bs",
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Text(
          "Last update at ${dolarPriceProvider.nextUpdateTime.toLocal()}",
        )
        // TODO: Add a percentage comparing this price and the previous one
      ],
    );
  }
}
