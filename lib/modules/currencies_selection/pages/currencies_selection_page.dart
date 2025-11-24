import 'package:doya/api/exchange_rate_api.dart';
import 'package:doya/providers/selected_currencies_provider.dart';
import 'package:doya/tokens/app/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:searchable_listview/searchable_listview.dart';

class CurrenciesSelectionPage extends HookConsumerWidget {
  const CurrenciesSelectionPage({super.key});
  static final List<String> dummyCurrencies = [
    "USD",
    "EUR",
    "CNY",
    "RUB",
    "JPY",
    "GBP",
    "INR",
    "CAD",
    "AUD",
    "BRL",
    "CHF",
    "HKD",
    "MXN",
    "NOK",
    "NZD",
    "TRY",
    "ZAR",
    "SEK",
    "DKK",
    "PLN",
    "CZK",
    "HUF",
    "ILS",
    "IDR",
    "MYR",
    "PHP",
    "THB",
    "RON",
    "SGD",
    "BGN",
    "HRK",
    "KRW",
    "AED",
    "ARS",
    "BOB",
    "CLP",
    "COP",
    "CRC",
    "CUP",
    "DOP",
    "EGP",
    "GTQ",
    "HNL",
    "ISK",
    "JMD",
    "KZT",
    "LAK",
    "LYD",
    "MOP",
    "MXV",
    "MYT",
    "NIO",
    "PAB",
    "PEN",
    "PHP",
    "QAR",
    "SAR",
    "SGD",
    "SRD",
    "TTD",
    "TWD",
    "VEF",
    "VND",
    "XAF",
    "XCD",
    "XOF",
    "YER",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCurrencies = ref.watch(
      selectedCurrenciesProvider,
    );
    final selectedCurrenciesNotifier = ref.read(
      selectedCurrenciesProvider.notifier,
    );

    var searchController = useTextEditingController();
    var maxAmount = useState<int>(5);
    var selectedAmount = useState<int>(0);

    void onCurrencySelected(String currency) {
      if (!selectedCurrencies.contains(currency) &&
          selectedAmount.value < maxAmount.value) {
        selectedCurrenciesNotifier.addCurrency(currency);
      } else {
        selectedCurrenciesNotifier.removeCurrency(currency);
      }
    }

    useEffect(() {
      ExchangeRateApi.getSupportedCurrencies();
      selectedAmount.value = selectedCurrencies.length;
      return null;
    }, [selectedCurrencies]);

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Seleccionar monedas"),
          subtitle: Text(
            'Has elegido ${selectedAmount.value} de ${maxAmount.value} monedas',
          ),
          trailing: ClearButton(
            notifier: selectedCurrenciesNotifier,
          ),
        ),
      ),
      body: SearchableList<String>(
        searchFieldPadding: EdgeInsets.only(
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.sm,
        ),
        searchTextController: searchController,
        labelText: "Buscar...",
        initialList: dummyCurrencies,
        itemBuilder: (currency) {
          var isSelected = selectedCurrencies.contains(currency);
          var enabled =
              selectedAmount.value < maxAmount.value ||
              isSelected;

          return CurrencyOption(
            enabled: enabled,
            currency: currency,
            isSelected: isSelected,
            onTap: onCurrencySelected,
          );
        },
        filter: currencyFilter,
      ),
    );
  }

  List<String> currencyFilter(text) {
    final newList = dummyCurrencies
        .where(
          (currency) => currency.toUpperCase().contains(
            text.toUpperCase(),
          ),
        )
        .toList();

    return newList;
  }
}

class ClearButton extends StatelessWidget {
  const ClearButton({super.key, required this.notifier});

  final SelectedCurrenciesNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: notifier.clear,
      icon: Icon(Icons.delete_sweep_rounded),
    );
  }
}

class FilterBar extends StatelessWidget {
  const FilterBar({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SearchBar(
      controller: searchController,
      leading: SizedBox(
        width: 48,
        child: Icon(
          Icons.search_rounded,
          color: theme.colorScheme.onSurface.withAlpha(100),
        ),
      ),
    );
  }
}

class CurrencyOption extends StatelessWidget {
  const CurrencyOption({
    super.key,
    required this.enabled,
    required this.currency,
    required this.isSelected,
    required this.onTap,
  });

  final bool enabled;
  final String currency;
  final bool isSelected;

  final void Function(String currency) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled,
      title: Text(currency),
      onTap: enabled ? () => onTap(currency) : null,
      trailing: Checkbox(
        value: isSelected,
        onChanged: enabled
            ? (value) {
                if (value == null) return;
                onTap(currency);
              }
            : null,
      ),
      titleTextStyle: TextStyle(
        decoration: enabled ? null : TextDecoration.lineThrough,
      ),
    );
  }
}
