import 'package:doya/providers/currency_exchange_provider.dart';
import 'package:doya/providers/main_currency_provider.dart';
import 'package:doya/providers/selected_currencies_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainCurrencySelectorDialog extends ConsumerWidget {
  const MainCurrencySelectorDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCurrencies = ref.watch(selectedCurrenciesProvider);
    final mainCurrencyNotifier = ref.read(
      mainCurrencyProvider.notifier,
    );
    final mainCurrency = ref.watch(mainCurrencyProvider);

    if (allCurrencies.isEmpty) {
      return SimpleDialog(
        title: Text("No hay monedas seleccionadas"),
      );
    }

    final ThemeData theme = Theme.of(context);

    return SimpleDialog(
      title: Text("Seleccionar moneda principal"),
      children: allCurrencies.map((currency) {
        return ListTile(
          selected: currency.code == mainCurrency.code,
          leading: Text(currency.symbol ?? ""),
          title: Text("${currency.code} - ${currency.name}"),
          onTap: () {
            final selected = ref
                .read(currencyExchangeProvider)
                .rates
                .rates[currency.code];
            if (selected == null) {
              Navigator.of(context).pop();
              return;
            }
            mainCurrencyNotifier.setMainCurrency(selected);
            Navigator.of(context).pop();
          },
          titleTextStyle: TextStyle(
            fontSize: theme.textTheme.bodyMedium?.fontSize,
            color: theme.colorScheme.onSurface,
          ),
          leadingAndTrailingTextStyle: TextStyle(
            fontSize: theme.textTheme.bodyLarge?.fontSize,
            color: theme.colorScheme.onSurface,
          ),
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
