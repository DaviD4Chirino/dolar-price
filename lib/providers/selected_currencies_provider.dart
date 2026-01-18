import 'dart:convert';

import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:doya/providers/currency_exchange_provider.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/constants/rate_source.dart';
import 'package:doya/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:doya/tokens/utils/modules/local_storage/models/local_storage_paths.dart';
import 'package:doya/tokens/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_currencies_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedCurrenciesNotifier
    extends _$SelectedCurrenciesNotifier {
  final defaultCurrencies = [
    SupportedCurrency(
      code: "USD",
      name: "Dólar BCV",
      symbol: getCurrencySymbol("USD"),
      source: RateSource.exchangeRateApi,
    ),
    SupportedCurrency(
      code: "EUR",
      name: "Euro",
      symbol: "€",
      source: RateSource.exchangeRateApi,
    ),
    SupportedCurrency(
      code: "CNY",
      name: "Yuan Chino",
      symbol: "¥",
      source: RateSource.exchangeRateApi,
    ),
    SupportedCurrency(
      code: "RUB",
      name: "Rublo Ruso",
      symbol: getCurrencySymbol("RUB"),
      source: RateSource.exchangeRateApi,
    ),
  ];

  @override
  List<SupportedCurrency> build() => loadCurrencies();

  void addCurrency(SupportedCurrency currency) {
    state = [...state, currency];
    Utils.log(state);
    saveCurrencies();
  }

  void removeCurrency(SupportedCurrency currency) {
    state = [...state]..remove(currency);
    Utils.log(state);
    saveCurrencies();
  }

  void clear() {
    state.clear();
    state = [];
    saveCurrencies();
  }

  void setCurrencies(List<SupportedCurrency> currencies) {
    state = currencies;
    saveCurrencies();
  }

  Future<void> saveCurrencies() async {
    final json = JsonCodec();
    await LocalStorage.setStringList(
      LocalStoragePaths.selectedCurrencies,
      state.map((e) => json.encode(e.toJson())).toList(),
    );
    ref.read(currencyExchangeProvider.notifier).fetchPrices();
  }

  List<SupportedCurrency> loadCurrencies() {
    try {
      final savedCurrencies = LocalStorage.getStringList(
        LocalStoragePaths.selectedCurrencies,
      );
      if (savedCurrencies == null || savedCurrencies.isEmpty) {
        Utils.log("No saved currencies or its empty");
        Utils.log("Using Default currencies");

        return defaultCurrencies;
      }

      return savedCurrencies
          .map((e) => SupportedCurrency.fromJson(jsonDecode(e)))
          .toList();
    } on Exception catch (e) {
      Utils.log(e);
      Utils.log("Using Default currencies");
      return defaultCurrencies;
    }
  }
}
