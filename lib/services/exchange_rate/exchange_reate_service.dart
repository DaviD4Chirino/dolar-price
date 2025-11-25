import 'dart:convert';

import 'package:doya/api/exchange_rate_api.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:doya/tokens/utils/modules/local_storage/models/local_storage_paths.dart';
import 'package:doya/tokens/utils/utils.dart';

abstract class ExchangeRateService {
  static Future<List<SupportedCurrency>?>
  getSupportedCurrencies() async {
    Utils.log("Getting supported currencies");

    try {
      final savedSupportedCurrencies =
          LocalStorage.getStringList(
            LocalStoragePaths.supportedCurrencies,
          );
      if (savedSupportedCurrencies != null) {
        final List<SupportedCurrency> supportedCurrenciesList =
            savedSupportedCurrencies
                .map(
                  (e) =>
                      SupportedCurrency.fromJson(jsonDecode(e)),
                )
                .toList();
        return supportedCurrenciesList;
      }
      final response =
          await ExchangeRateApi.getSupportedCurrencies();

      if (response == null) return null;

      final List<dynamic>? supportedCurrencies =
          response["supported_codes"];

      if (supportedCurrencies == null) return null;

      final List<SupportedCurrency> supportedCurrenciesList =
          supportedCurrencies
              .map((e) => SupportedCurrency.fromList(e))
              .toList();
      await LocalStorage.setStringList(
        LocalStoragePaths.supportedCurrencies,
        supportedCurrenciesList
            .map((e) => jsonEncode(e.toJson()))
            .toList(),
      );

      return supportedCurrenciesList;
    } catch (e) {
      Utils.log(e);
      rethrow;
    }
  }
}
