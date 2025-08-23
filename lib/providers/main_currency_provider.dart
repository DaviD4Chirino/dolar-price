import 'package:awesome_dolar_price/providers/currency_exchange_provider.dart';
import 'package:awesome_dolar_price/tokens/models/currencies.dart';
import 'package:awesome_dolar_price/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:awesome_dolar_price/tokens/utils/modules/local_storage/models/local_storage_paths.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_currency_provider.g.dart';

/// Use this to change the main currency,
/// Use [Currencies] to compare the currency
@Riverpod(keepAlive: true)
class MainCurrencyNotifier extends _$MainCurrencyNotifier {
  @override
  String build() {
    return getMainCurrency() ?? Currencies.usd;
  }

  void setMainCurrency(String currency) {
    if (!Currencies.isCurrency(currency)) {
      throw Exception("$currency Is not a valid currency");
    }
    state = currency;
    saveMainCurrency();
    if (ref.read(currencyExchangeNotifierProvider) == currency) {
      return;
    }
    ref
        .read(currencyExchangeNotifierProvider.notifier)
        .updatePreviousExchangeValue();
  }

  Future<void> saveMainCurrency() async {
    return LocalStorage.setString(
      LocalStoragePaths.mainCurrency,
      state,
    );
  }

  String? getMainCurrency() {
    return LocalStorage.getString(
      LocalStoragePaths.mainCurrency,
    );
  }
}
