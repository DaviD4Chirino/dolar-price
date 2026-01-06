import 'dart:convert';

import 'package:doya/providers/currency_exchange_provider.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/constants/rate_source.dart';
import 'package:doya/tokens/models/currencies.dart';
import 'package:doya/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:doya/tokens/utils/modules/local_storage/models/local_storage_paths.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_currency_provider.g.dart';

/// Use this to change the main currency,
/// Use [Currencies] to compare the currency
@Riverpod(keepAlive: true)
class MainCurrencyNotifier extends _$MainCurrencyNotifier {
  final defaultCurrency = SupportedCurrency(
    code: "USD",
    name: "Dólar",
    source: RateSource.exchangeRateApi,
  );

  @override
  SupportedCurrency build() => getMainCurrency();

  void setMainCurrency(SupportedCurrency currency) {
    state = currency;
    saveMainCurrency();
    ref
        .read(currencyExchangeProvider.notifier)
        .updatePreviousExchangeValue();
  }

  Future<void> saveMainCurrency() async {
    return LocalStorage.setString(
      LocalStoragePaths.mainCurrency,
      jsonEncode(state.toJson()),
    );
  }

  SupportedCurrency getMainCurrency() {
    final savedValue = LocalStorage.getString(
      LocalStoragePaths.mainCurrency,
    );

    return savedValue != null
        ? SupportedCurrency.fromJson(jsonDecode(savedValue))
        : defaultCurrency;
  }
}
