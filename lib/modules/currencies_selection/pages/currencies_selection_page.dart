import 'package:doya/tokens/app/app_spacing.dart';
import 'package:doya/tokens/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:searchable_listview/searchable_listview.dart';

class CurrenciesSelectionPage extends HookWidget {
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
  Widget build(BuildContext context) {
    var searchController = useTextEditingController();
    var selectedCurrencies = useState<List<String>>([]);
    var maxAmount = useState<int>(5);
    var selectedAmount = useState<int>(0);

    void onCurrencySelected(String currency) {
      if (!selectedCurrencies.value.contains(currency) &&
          selectedAmount.value < maxAmount.value) {
        selectedCurrencies.value = [
          ...selectedCurrencies.value,
          currency,
        ];
      } else {
        selectedCurrencies.value = [
          ...selectedCurrencies.value..remove(currency),
        ];
      }
      Utils.log(selectedCurrencies.value);
    }

    useEffect(() {
      selectedAmount.value = selectedCurrencies.value.length;
      return null;
    }, [selectedCurrencies.value]);

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Seleccionar monedas"),
          subtitle: Text(
            'Has elegido ${selectedAmount.value} de ${maxAmount.value} monedas',
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
          var isSelected = selectedCurrencies.value.contains(
            currency,
          );
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
        filter: (text) => dummyCurrencies
            .where(
              (currency) => currency.toUpperCase().contains(
                text.toUpperCase(),
              ),
            )
            .toList(),
      ),
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
