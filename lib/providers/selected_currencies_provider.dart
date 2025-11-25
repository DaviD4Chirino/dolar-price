import 'dart:convert';

import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:doya/tokens/utils/modules/local_storage/models/local_storage_paths.dart';
import 'package:doya/tokens/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_currencies_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedCurrenciesNotifier
    extends _$SelectedCurrenciesNotifier {
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
