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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCurrencies = ref.watch(
      selectedCurrenciesProvider,
    );
    final selectedCurrenciesNotifier = ref.read(
      selectedCurrenciesProvider.notifier,
    );

    var supportedCurrencies =
        useState<Future<List<SupportedCurrency>?>>(
          Future.value([]),
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
      selectedAmount.value = selectedCurrencies.length;
    }

    useEffect(() {
      selectedAmount.value = selectedCurrencies.length;
      return null;
    }, [selectedCurrencies.length]);

    useEffect(() {
      supportedCurrencies.value =
          ExchangeRateService.getSupportedCurrencies();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Seleccionar divisas"),
          subtitle: Text(
            'Has elegido ${selectedAmount.value} de ${maxAmount.value} monedas',
          ),
          trailing: ClearButton(
            notifier: selectedCurrenciesNotifier,
          ),
        ),
      ),
      body: FutureBuilder(
        future: supportedCurrencies.value,
        builder: (context, asyncSnapshot) {
          switch (asyncSnapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              switch (asyncSnapshot.data) {
                case null:
                  return const Center(
                    child: Text("No hay Divisas para mostrar"),
                  );

                default:
                  return SearchList(
                    searchController: searchController,
                    supportedCurrencies: asyncSnapshot.data!,
                    maxAmount: 5,
                    selectedAmount: selectedAmount.value,
                    selectedCurrencies: selectedCurrencies,
                    onCurrencySelected: onCurrencySelected,
                    filter: currencyFilter,
                  );
              }

            default:
              return const Center(
                child: Text("No hay Divisas para mostrar"),
              );
          }
        },
      ),
    );
  }

  bool currencyFilter(String text, SupportedCurrency currency) {
    final formattedText = text.toUpperCase();
    return currency.code.toUpperCase().contains(formattedText) ||
        currency.name.toUpperCase().contains(formattedText);
  }
}

class SearchList extends StatefulWidget {
  const SearchList({
    super.key,
    required this.searchController,
    required this.supportedCurrencies,
    required this.maxAmount,
    required this.selectedAmount,
    required this.selectedCurrencies,
    required this.onCurrencySelected,
    required this.filter,
  });

  final TextEditingController searchController;
  final List<SupportedCurrency> supportedCurrencies;
  final int maxAmount;
  final int selectedAmount;
  final List<SupportedCurrency> selectedCurrencies;
  final bool Function(String, SupportedCurrency) filter;
  final void Function(SupportedCurrency currency)
  onCurrencySelected;

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return SearchableList<SupportedCurrency>(
      searchFieldPadding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.sm,
      ),
      searchTextController: widget.searchController,
      labelText: "Buscar...",
      initialList: widget.supportedCurrencies,
      loadingWidget: loadingWidget(),
      itemBuilder: itemBuilder,
      filter: currencyFilter,
    );
  }

  List<SupportedCurrency> currencyFilter(String text) => widget
      .supportedCurrencies
      .where((currency) => widget.filter(text, currency))
      .toList();

  Widget loadingWidget() {
    return Center(child: CircularProgressIndicator());
  }

  Widget itemBuilder(currency) {
    var isSelected = widget.selectedCurrencies.contains(
      currency,
    );
    var enabled =
        widget.selectedAmount < widget.maxAmount || isSelected;

    return CurrencyOption(
      enabled: enabled,
      currency: currency,
      isSelected: isSelected,
      onTap: widget.onCurrencySelected,
    );
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
