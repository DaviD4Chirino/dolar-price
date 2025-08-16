import 'package:awesome_dolar_price/tokens/models/currency_rates.dart';

class CurrencyExchange {
  CurrencyExchange({
    required this.lastUpdateTime,
    required this.nextUpdateTime,
    required this.rates,
  });

  DateTime lastUpdateTime;
  String nextUpdateTime;

  CurrencyRates rates;

  CurrencyExchange.fromJson(Map<String, dynamic> json)
      : lastUpdateTime =
            DateTime.fromMillisecondsSinceEpoch(json["time_last_update_unix"]),
        nextUpdateTime = json["time_next_update_unix"],
        rates = CurrencyRates(
          json["rates"]["USD"],
          json["rates"]["EUR"],
          json["rates"]["CNY"],
          json["rates"]["RUB"],
        );
  Map<String, dynamic> toJson() {
    return {
      "time_last_update_unix": lastUpdateTime.millisecondsSinceEpoch,
      "time_next_update_unix": nextUpdateTime,
      "rates": {
        "USD": rates.usd,
        "EUR": rates.eur,
        "RUB": rates.rub,
        "CNY": rates.cny,
      }
    };
  }
}
