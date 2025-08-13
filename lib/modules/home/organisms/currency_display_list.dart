import 'package:awesome_dolar_price/modules/home/molecule/currency_display_molecule.dart';
import 'package:awesome_dolar_price/providers/dolar_price.dart';
import 'package:awesome_dolar_price/tokens/app/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrencyDisplayList extends ConsumerWidget {
  const CurrencyDisplayList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dolarPriceProvider = ref.watch(dolarPriceNotifierProvider);
    var entries = dolarPriceProvider.rates.currencies.entries.map(
      (e) => CurrencyDisplayMolecule(
        currency: e.key,
        value: e.value > 0.0
            ? e.value.toStringAsFixed(3)
            : e.value.toStringAsFixed(0),
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.md,
      children: entries.toList(),
    );
  }
}
