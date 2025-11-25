import 'package:doya/providers/selected_currencies_provider.dart';
import 'package:doya/services/exchange_rate/exchange_reate_service.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/app/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:searchable_listview/searchable_listview.dart';

class CurrenciesSelectionPage extends HookConsumerWidget {
  const CurrenciesSelectionPage({super.key});
  static final List<SupportedCurrency> dummyCurrencies = [
    SupportedCurrency(code: "USD", name: "USD"),
    SupportedCurrency(code: "EUR", name: "EUR"),
    SupportedCurrency(code: "CNY", name: "CNY"),
    SupportedCurrency(code: "RUB", name: "RUB"),
    SupportedCurrency(code: "JPY", name: "JPY"),
    SupportedCurrency(code: "GBP", name: "GBP"),
    SupportedCurrency(code: "INR", name: "INR"),
    SupportedCurrency(code: "CAD", name: "CAD"),
    SupportedCurrency(code: "AUD", name: "AUD"),
    SupportedCurrency(code: "BRL", name: "BRL"),
    SupportedCurrency(code: "CHF", name: "CHF"),
    SupportedCurrency(code: "HKD", name: "HKD"),
    SupportedCurrency(code: "MXN", name: "MXN"),
    SupportedCurrency(code: "NOK", name: "NOK"),
    SupportedCurrency(code: "NZD", name: "NZD"),
    SupportedCurrency(code: "TRY", name: "TRY"),
    SupportedCurrency(code: "ZAR", name: "ZAR"),
    SupportedCurrency(code: "SEK", name: "SEK"),
    SupportedCurrency(code: "DKK", name: "DKK"),
    SupportedCurrency(code: "PLN", name: "PLN"),
    SupportedCurrency(code: "CZK", name: "CZK"),
    SupportedCurrency(code: "HUF", name: "HUF"),
    SupportedCurrency(code: "ILS", name: "ILS"),
    SupportedCurrency(code: "IDR", name: "IDR"),
    SupportedCurrency(code: "MYR", name: "MYR"),
    SupportedCurrency(code: "PHP", name: "PHP"),
    SupportedCurrency(code: "THB", name: "THB"),
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

    void onCurrencySelected(SupportedCurrency currency) {
      if (!selectedCurrencies.contains(currency) &&
          selectedAmount.value < maxAmount.value) {
        selectedCurrenciesNotifier.addCurrency(currency);
      } else {
        selectedCurrenciesNotifier.removeCurrency(currency);
      }
    }

    useEffect(() {
      selectedAmount.value = selectedCurrencies.length;
      return null;
    }, [selectedCurrencies]);

    useEffect(() {
      if (selectedCurrencies.isEmpty) {
        return;
      }
      ExchangeRateService.getSupportedCurrencies().then((value) {
        if (value == null) return;
        selectedCurrenciesNotifier.setCurrencies(value);
      });
      return null;
    }, []);

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
      body: SearchableList<SupportedCurrency>(
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

  List<SupportedCurrency> currencyFilter(text) {
    final formattedText = text.toUpperCase();
    final newList = dummyCurrencies
        .where(
          (currency) =>
              currency.code.toUpperCase().contains(
                formattedText,
              ) ||
              currency.name.toUpperCase().contains(
                formattedText,
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
  final SupportedCurrency currency;
  final bool isSelected;

  final void Function(SupportedCurrency currency) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled,
      title: Text("${currency.code} - ${currency.name}"),
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
