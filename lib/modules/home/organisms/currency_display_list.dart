import 'package:doya/modules/home/molecule/currency_display_molecule.dart';
import 'package:doya/providers/currency_exchange_provider.dart';
import 'package:doya/providers/main_currency_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrencyDisplayList extends ConsumerWidget {
  const CurrencyDisplayList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dolarPriceProvider = ref.watch(
      currencyExchangeProvider,
    );

    // var t = AppLocalizations.of(context);

    var mainCurrencyNotifier = ref.read(
      mainCurrencyProvider.notifier,
    );

    // var parallel = dolarPriceProvider.rates.usdParallel;
    // var dolar = dolarPriceProvider.rates.usd;
    var allRates = dolarPriceProvider.rates.allValues;
    /*  allRates.remove("USD_PARALLEL");
    allRates.remove("USD"); */

    var entries = allRates.entries
        .where((e) => e.value.rate != 0)
        .map(
          (e) => CurrencyDisplayMolecule(
            currency: e.value,
            onTap: () =>
                mainCurrencyNotifier.setMainCurrency(e.value),
          ),
        );
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        /* CurrencyDisplayMolecule(
          currency: Currencies.usd,
          title: "\$ Dólar BCV",
          value: dolar > 0.0
              ? dolar.toStringAsFixed(3)
              : dolar.toStringAsFixed(0),
          onTap: () => mainCurrencyNotifier.setMainCurrency(
            Currencies.usd,
          ),
        ),
        CurrencyDisplayMolecule(
          currency: Currencies.usd,
          title: "\$ Dólar Paralelo",
          value: parallel > 0.0
              ? parallel.toStringAsFixed(3)
              : parallel.toStringAsFixed(0),

          onTap: () => mainCurrencyNotifier.setMainCurrency(
            Currencies.usdParallel,
          ),
        ),
        Divider(), */
        ...entries,
      ],
    );
  }
}
