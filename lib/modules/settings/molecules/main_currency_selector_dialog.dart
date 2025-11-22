import 'package:doya/providers/main_currency_provider.dart';
import 'package:doya/tokens/models/currencies.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainCurrencySelectorDialog extends ConsumerWidget {
  const MainCurrencySelectorDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainCurrencyNotifier = ref.read(
      mainCurrencyProvider.notifier,
    );

    return SimpleDialog(
      title: Text("Seleccionar moneda principal"),
      children: Currencies.allCurrencies.map((currency) {
        return ListTile(
          title: Text(
            Currencies.getCurrencyTitle(
              currency,
              // context: context,
            ),
          ),
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
