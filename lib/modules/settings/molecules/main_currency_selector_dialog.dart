import 'package:doya/providers/main_currency_provider.dart';
import 'package:doya/tokens/utils/dolar/dolar_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainCurrencySelectorDialog extends ConsumerWidget {
  const MainCurrencySelectorDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCurrencies = DolarUtils.getSelectedCurrencies();
    final mainCurrencyNotifier = ref.read(
      mainCurrencyProvider.notifier,
    );

    if (allCurrencies == null) {
      return SimpleDialog(
        title: Text("No hay monedas seleccionadas"),
      );
    }

    return SimpleDialog(
      title: Text("Seleccionar moneda principal"),
      children: allCurrencies.map((currency) {
        return ListTile(
          title: Text(currency.name),
          onTap: () {
            mainCurrencyNotifier.setMainCurrency(currency);
            Navigator.of(context).pop();
          },
        );
      }).toList(),

      /* ListTile(
          leading: Icon(Icons.currency_exchange_rounded),
          title: Text("USD"),
          onTap: () {
            mainCurrencyNotifier.setMainCurrency("USD");
          },
        ),
        ListTile(
          leading: Icon(Icons.currency_exchange_rounded),
          title: Text("EUR"),
          onTap: () {
            mainCurrencyNotifier.setMainCurrency("EUR");
          },
        ),
        ListTile(
          leading: Icon(Icons.currency_exchange_rounded),
          title: Text("CNY"),
          onTap: () {
            mainCurrencyNotifier.setMainCurrency("CNY");
          },
        ),
        ListTile(
          leading: Icon(Icons.currency_exchange_rounded),
          title: Text("RUB"),
          onTap: () {
            mainCurrencyNotifier.setMainCurrency("RUB");
          },
        ), */
    );
  }
}
