import 'package:awesome_dolar_price/providers/main_currency_provider.dart';
import 'package:awesome_dolar_price/tokens/models/currencies.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrencySelectorDialog extends ConsumerWidget {
  const CurrencySelectorDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainCurrencyNotifier = ref.read(
      mainCurrencyNotifierProvider.notifier,
    );

    return SimpleDialog(
      title: Text("Select currency"),
      children: Currencies.allCurrencies.map((currency) {
        return ListTile(
          title: Text(
            Currencies.getCurrencyTitle(
              currency,
              context: context,
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
