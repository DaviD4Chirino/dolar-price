import 'package:doya/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:doya/tokens/utils/modules/local_storage/models/local_storage_paths.dart';
import 'package:doya/tokens/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_currencies_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedCurrenciesNotifier
    extends _$SelectedCurrenciesNotifier {
  @override
  List<String> build() => [];

  void addCurrency(String currency) {
    state = [...state, currency];
    Utils.log(state);
    saveCurrencies();
  }

  void removeCurrency(String currency) {
    state = [...state]..remove(currency);
    Utils.log(state);
    saveCurrencies();
  }

  void clear() {
    state = [];
    saveCurrencies();
  }

  void setCurrencies(List<String> currencies) {
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
    state = savedCurrencies;
  }

  Future<void> saveCurrencies() async {
    await LocalStorage.setStringList(
      LocalStoragePaths.selectedCurrencies,
      state,
    );
  }
}
