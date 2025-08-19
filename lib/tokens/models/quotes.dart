import 'package:awesome_dolar_price/tokens/models/currency_rates.dart';

class Quotes {
  Quotes({
    required this.lastUpdateTime,
    required this.nextUpdateTime,
    required this.rates,
    this.lastQuote,
  });

  String lastUpdateTime;
  String nextUpdateTime;

  CurrencyRates rates;

  Quotes? lastQuote;

  Quotes.fromJson(Map<String, dynamic> json)
    : lastUpdateTime =
          json["time_last_update"] ?? DateTime.timestamp().toString(),
      nextUpdateTime =
          json["time_next_update"] ?? DateTime.timestamp().toString(),
      rates = CurrencyRates(
        json["rates"]["USD"] ?? 0,
        json["rates"]["EUR"] ?? 0,
        json["rates"]["CNY"] ?? 0,
        json["rates"]["RUB"] ?? 0,
      ),
      lastQuote = json["last_quote"] != null
          ? Quotes.fromJson(json["last_quote"])
          : null;

  Map<String, dynamic> toJson() {
    return {
      "time_last_update": lastUpdateTime,
      "time_next_update": nextUpdateTime,
      "rates": rates.allRates,
      "last_quote": lastQuote?.toJson(),
    };
  }
}
