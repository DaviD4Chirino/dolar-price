import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/constants/rate_source.dart';

abstract class DolarApiService {
  static Future<List<SupportedCurrency>?>
  getSupportedCurrencies() async {
    return [
      SupportedCurrency(
        code: "USD",
        name: "Dolar (Paralelo)",
        symbol: "\$",
        source: RateSource.dolarApi,
      ),
    ];
  }
}
