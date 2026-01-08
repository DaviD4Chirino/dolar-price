import 'package:doya/providers/selected_currencies_provider.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/app/app_spacing.dart';
import 'package:doya/tokens/utils/dolar/dolar_utils.dart';
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
    /* final selectedCurrenciesNotifier = ref.read(
      selectedCurrenciesProvider.notifier,
    ); */

    var chosenCurrencies = useState<List<SupportedCurrency>>([
      ...selectedCurrencies,
    ]);

    var supportedCurrencies =
        useState<Future<List<SupportedCurrency>?>>(
          Future.value([]),
        );
    var searchController = useTextEditingController();
    var maxAmount = useState<int>(5);
    var selectedAmount = useState<int>(0);

    void onClear() {
      chosenCurrencies.value.clear();
      selectedAmount.value = 0;
    }

    void onCurrencySelected(SupportedCurrency currency) {
      if (!chosenCurrencies.value.contains(currency) &&
          selectedAmount.value < maxAmount.value) {
        chosenCurrencies.value.add(currency);
        // selectedCurrenciesNotifier.addCurrency(currency);
      } else {
        chosenCurrencies.value.remove(currency);
        // selectedCurrenciesNotifier.removeCurrency(currency);
      }
      selectedAmount.value = chosenCurrencies.value.length;
    }

    useEffect(() {
      selectedAmount.value = chosenCurrencies.value.length;
      return null;
    }, [chosenCurrencies.value.length]);

    useEffect(() {
      supportedCurrencies.value =
          DolarUtils.getSupportedCurrencies();
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: appBarTitle(
          onPressed: onClear,
          selectedAmount: selectedAmount,
          maxAmount: maxAmount,
        ),
      ),
      bottomNavigationBar: chosenCurrencies.value.isNotEmpty
          ? SelectedCurrenciesChips(
              selectedCurrencies: chosenCurrencies.value,
              onDeleted: chosenCurrencies.value.remove,
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(selectedCurrenciesProvider.notifier)
              .setCurrencies(chosenCurrencies.value);
          Navigator.of(context).pop();
        },

        tooltip: 'Guardar divisas',
        child: const Icon(Icons.done_all_rounded),
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
                    maxAmount: maxAmount.value,
                    selectedAmount: selectedAmount.value,
                    selectedCurrencies: chosenCurrencies.value,
                    onCurrencySelected: onCurrencySelected,
                    filter: currencyFilter,
                  );
              }

            default:
              return const Center(
                child: ListTile(
                  title: Text("No hay Divisas para mostrar"),
                  leading: Icon(Icons.search_off_rounded),
                ),
              );
          }
        },
      ),
    );
  }

  ListTile appBarTitle({
    required ValueNotifier<int> selectedAmount,
    required ValueNotifier<int> maxAmount,
    required void Function()? onPressed,
  }) {
    return ListTile(
      title: Text("Seleccionar divisas"),
      subtitle: Text(
        '${selectedAmount.value} de ${maxAmount.value} monedas seleccionadas',
      ),
      trailing: ClearButton(onPressed: onPressed),
    );
  }

  bool currencyFilter(String text, SupportedCurrency currency) {
    final formattedText = text.toUpperCase();
    return currency.code.toUpperCase().contains(formattedText) ||
        currency.name.toUpperCase().contains(formattedText) ||
        currency.symbol != null &&
            currency.symbol!.toUpperCase().contains(
              formattedText,
            );
  }
}

class SelectedCurrenciesChips extends StatelessWidget {
  const SelectedCurrenciesChips({
    super.key,
    required this.selectedCurrencies,
    this.onDeleted,
  });
  final List<SupportedCurrency> selectedCurrencies;
  final void Function(SupportedCurrency currency)? onDeleted;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      color: theme.colorScheme.surfaceContainerHigh,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        runAlignment: WrapAlignment.start,
        spacing: AppSpacing.sm,
        children: selectedCurrencies
            .map(
              (currency) => Chip(
                label: Text(currency.code),
                deleteIcon: Icon(Icons.close),
                onDeleted: onDeleted != null
                    ? () => onDeleted!(currency)
                    : null,
              ),
            )
            .toList(),
      ),
    );
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
      labelText: "Filtre por...",
      initialList: widget.supportedCurrencies,
      loadingWidget: loadingWidget(),
      emptyWidget: emptyWidget(),
      itemBuilder: itemBuilder,
      filter: currencyFilter,
      closeKeyboardWhenScrolling: true,
    );
  }

  List<SupportedCurrency> currencyFilter(String text) {
    final list =
        widget.supportedCurrencies
            .where((currency) => widget.filter(text, currency))
            .toList()
          ..sort(
            (a, b) =>
                widget.selectedCurrencies.contains(a) ? -1 : 1,
          );

    return list;
  }

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

  Widget emptyWidget() {
    return ListTile(
      leading: Icon(Icons.search_off_rounded),
      title: Text("No hay divisas con ese nombre o código"),
    );
  }
}

class ClearButton extends StatelessWidget {
  const ClearButton({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.delete_sweep_rounded),
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
    final ThemeData theme = Theme.of(context);
    return ListTile(
      enabled: enabled,
      leading: Text(currency.symbol ?? ""),
      title: Text("${currency.code} - ${currency.name}"),
      onTap: enabled ? () => onTap(currency) : null,
      trailing: checkBox(),
      titleTextStyle: TextStyle(
        decoration: enabled ? null : TextDecoration.lineThrough,
        fontSize: theme.textTheme.bodyMedium?.fontSize,
        // For some reason, the text is blanc on some devices
        color: theme.colorScheme.onSurface,
      ),

      leadingAndTrailingTextStyle: TextStyle(
        decoration: enabled ? null : TextDecoration.lineThrough,
        fontSize: theme.textTheme.bodyLarge?.fontSize,
        // For some reason, the text is blanc on some devices
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Checkbox checkBox() {
    return Checkbox(
      value: isSelected,
      onChanged: enabled
          ? (value) {
              if (value == null) return;
              onTap(currency);
            }
          : null,
    );
  }
}
