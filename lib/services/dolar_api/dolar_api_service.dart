import 'package:doya/api/dolar_api.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/constants/rate_source.dart';
import 'package:doya/tokens/models/currency_rates.dart';
import 'package:doya/tokens/utils/utils.dart';

abstract class DolarApiService {
  static Future<CurrencyRates?> getRate(
    SupportedCurrency currency,
  ) async {
    try {
      final res = await DolarApi.getPairConversion(
        currency.code,
      );
      Map<String, SupportedCurrency> values = {};

      if (res != null) {
        switch (currency.code) {
          case "USD":
            values["USD"] = currency.copyWith(
              rate: res["promedio"] ?? 0,
            );
          case "USD_PARALLEL":
            values["USD_PARALLEL"] = currency.copyWith(
              rate: res["promedio"] ?? 0,
            );

          case "BTC":
            values["BTC"] = currency.copyWith(
              rate: res["promedio"] ?? 0,
            );
        }
        return CurrencyRates(rates: values);
      }
    } on Exception catch (e) {
      Utils.log(e);
    }
    return null;
  }

  static Future<List<SupportedCurrency>?>
  getSupportedCurrencies() async {
    return [
      SupportedCurrency(
        code: "USD",
        name: "Dólar",
        symbol: "\$",
        source: RateSource.dolarApi,
      ),
      SupportedCurrency(
        code: "BTC",
        name: "Dólar Bitcoin",
        symbol: "₿",
        source: RateSource.dolarApi,
      ),
      SupportedCurrency(
        code: "USD_PARALLEL",
        name: "Dólar Paralelo",
        symbol: "\$",
        source: RateSource.dolarApi,
      ),
    ];
  }
}
