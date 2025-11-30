import 'dart:convert';

import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/constants/rate_source.dart';
import 'package:doya/tokens/utils/dolar/dolar_utils.dart';
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
      name: "United States Dollar",
      source: RateSource.exchangeRateApi,
    ),
    SupportedCurrency(
      code: "EUR",
      name: "Euro",
      source: RateSource.exchangeRateApi,
    ),
    SupportedCurrency(
      code: "CNY",
      name: "Chinese Yuan",
      source: RateSource.exchangeRateApi,
    ),
    SupportedCurrency(
      code: "RUB",
      name: "Russian Ruble",
      source: RateSource.exchangeRateApi,
    ),
    SupportedCurrency(
      code: "USD_PARALLEL",
      name: "US Dollar Parallel",
      source: RateSource.exchangeRateApi,
    ),
  ];

  @override
  List<SupportedCurrency> build() => [];

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

  void loadCurrencies() async {
    final savedCurrencies = LocalStorage.getStringList(
      LocalStoragePaths.selectedCurrencies,
    );
    if (savedCurrencies == null) {
      Utils.log("No saved currencies");
      Utils.log("Using Default currencies");

      state = defaultCurrencies;
      await Future.delayed(Duration(milliseconds: 100));
      saveCurrencies();
      return;
    }
    final json = JsonCodec();
    state = savedCurrencies
        .map((e) => SupportedCurrency.fromJson(json.decode(e)))
        .toList();
  }

  Future<void> saveCurrencies() async {
    final json = JsonCodec();
    await LocalStorage.setStringList(
      LocalStoragePaths.selectedCurrencies,
      state.map((e) => json.encode(e.toJson())).toList(),
    );
  }
}
