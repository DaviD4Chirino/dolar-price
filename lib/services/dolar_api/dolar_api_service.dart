import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/constants/rate_source.dart';

abstract class DolarApiService {
  static Future<List<SupportedCurrency>?>
  getSupportedCurrencies() async {
    return [
      SupportedCurrency(
        code: "USD",
        name: "Dolar",
        symbol: "\$",
        source: RateSource.dolarApi,
      ),
      SupportedCurrency(
        code: "BTC",
        name: "Dolar",
        symbol: getCurrencySymbol("BTC"),
        source: RateSource.dolarApi,
      ),
      SupportedCurrency(
        code: "USD",
        name: "Dólar Paralelo",
        symbol: "\$",
        source: RateSource.dolarApi,
      ),
    ];
  }
}
