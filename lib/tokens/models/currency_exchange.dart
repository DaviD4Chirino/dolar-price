import 'package:awesome_dolar_price/tokens/models/currency_rates.dart';

class CurrencyExchange {
  CurrencyExchange({
    required this.lastUpdateTime,
    required this.nextUpdateTime,
    required this.rates,
  });

  String lastUpdateTime;
  String nextUpdateTime;

  CurrencyRates rates;

  CurrencyExchange.fromJson(Map<String, dynamic> json)
      : lastUpdateTime =
            json["time_last_update"] ?? DateTime.timestamp().toString(),
        nextUpdateTime =
            json["time_next_update"] ?? DateTime.timestamp().toString(),
        rates = CurrencyRates(
          json["rates"]["USD"] ?? 0,
          json["rates"]["EUR"] ?? 0,
          json["rates"]["CNY"] ?? 0,
          json["rates"]["RUB"] ?? 0,
        );

  Map<String, dynamic> toJson() {
    return {
      "time_last_update": lastUpdateTime,
      "time_next_update": nextUpdateTime,
      "rates": {
        "USD": rates.usd,
        "EUR": rates.eur,
        "RUB": rates.rub,
        "CNY": rates.cny,
      }
    };
  }
}
