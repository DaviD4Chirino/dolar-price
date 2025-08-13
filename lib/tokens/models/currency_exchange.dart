import 'package:awesome_dolar_price/tokens/models/currency_rates.dart';

class CurrencyExchange {
  CurrencyExchange({
    required this.lastUpdateTime,
    required this.nextUpdateTime,
    required this.rates,
  });

  DateTime lastUpdateTime;
  DateTime nextUpdateTime;

  CurrencyRates rates;

  CurrencyExchange.fromJson(Map<String, dynamic> json)
      : lastUpdateTime = json["time_last_update_utc"],
        nextUpdateTime = json["time_next_update_utc"],
        rates = CurrencyRates(
          json["rates"]["USD"],
          json["rates"]["EUR"],
          json["rates"]["CNY"],
          json["rates"]["RUB"],
        );
}
