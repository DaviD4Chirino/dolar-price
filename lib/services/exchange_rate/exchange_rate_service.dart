import 'dart:convert';

import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:doya/api/exchange_rate_api.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/constants/rate_source.dart';
import 'package:doya/tokens/models/currency_rates.dart';
import 'package:doya/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:doya/tokens/utils/modules/local_storage/models/local_storage_paths.dart';
import 'package:doya/tokens/utils/utils.dart';

abstract class ExchangeRateService {
  static Future<CurrencyRates?> getRate(
    SupportedCurrency currency,
  ) async {
    try {
      final res = await ExchangeRateApi.getPairConversion(
        currency.code,
      );

      if (res == null) return null;

      var conversionRate = res["conversion_rate"];

      Map<String, SupportedCurrency> values = {
        res["base_code"]: currency.copyWith(
          rate: conversionRate != null && conversionRate is num
              ? conversionRate.toDouble()
              : 0.0,
        ),
      };
      return CurrencyRates(allValues: values);
    } on Exception catch (e) {
      Utils.log(e);
    }
    return null;
  }

  static Future<List<SupportedCurrency>?>
  getSupportedCurrencies({bool earlyThrow = false}) async {
    Utils.log("Getting supported currencies");

    try {
      if (earlyThrow) throw Exception("Early throw");

      final response =
          await ExchangeRateApi.getSupportedCurrencies(
            earlyThrow: earlyThrow,
          );

      if (response == null) return null;

      final List<dynamic>? supportedCurrencies =
          response["supported_codes"];

      if (supportedCurrencies == null) return null;

      final List<SupportedCurrency> supportedCurrenciesList =
          supportedCurrencies
              .map(
                (e) => SupportedCurrency(
                  code: e.first,
                  name: e.last,
                  symbol: getCurrencySymbol(e.first),
                  source: RateSource.exchangeRateApi,
                ),
              )
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
