import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:awesome_dolar_price/modules/home/molecule/currency_display_molecule.dart';
import 'package:awesome_dolar_price/providers/currency_exchange_provider.dart';
import 'package:awesome_dolar_price/tokens/app/app_spacing.dart';
import 'package:awesome_dolar_price/tokens/models/currencies.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrencyDisplayList extends ConsumerWidget {
  const CurrencyDisplayList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dolarPriceProvider = ref.watch(
      currencyExchangeNotifierProvider,
    );

    var t = AppLocalizations.of(context);

    var parallel = dolarPriceProvider.rates.usdParallel;
    var dolar = dolarPriceProvider.rates.usd;
    var allRates = dolarPriceProvider.rates.allRates;
    allRates.remove("BTC");
    allRates.remove("USD_PARALLEL");
    allRates.remove("USD");

    var entries = allRates.entries.map(
      (e) => CurrencyDisplayMolecule(
        currency: e.key,
        title: Currencies.getCurrencyTitle(
          e.key,
          context: context,
          withoutSymbol: true,
        ),
        value: e.value > 0.0
            ? e.value.toStringAsFixed(3)
            : e.value.toStringAsFixed(0),
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.max,
      spacing: AppSpacing.md,
      children: [
        CurrencyDisplayMolecule(
          currency: "USD",
          title: t.currencyDolar,
          value: dolar > 0.0
              ? dolar.toStringAsFixed(3)
              : dolar.toStringAsFixed(0),
        ),
        CurrencyDisplayMolecule(
          currency: "USD",
          title: t.currencyParallel,
          value: parallel > 0.0
              ? parallel.toStringAsFixed(3)
              : parallel.toStringAsFixed(0),
        ),
        Divider(),
        ...entries,
      ],
    );
  }
}
