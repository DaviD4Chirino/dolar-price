import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/models/currency_rates.dart';

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

  Quotes copyWith({
    String? lastUpdateTime,
    String? nextUpdateTime,
    CurrencyRates? rates,
    Quotes? lastQuote,
  }) {
    return Quotes(
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      nextUpdateTime: nextUpdateTime ?? this.nextUpdateTime,
      rates: rates ?? this.rates,
      lastQuote: lastQuote ?? this.lastQuote,
    );
  }

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is Quotes &&
          runtimeType == other.runtimeType &&
          lastUpdateTime == other.lastUpdateTime &&
          nextUpdateTime == other.nextUpdateTime &&
          rates == other.rates &&
          lastQuote == other.lastQuote;
  @override
  int get hashCode => Object.hash(
    lastUpdateTime,
    nextUpdateTime,
    rates,
    lastQuote,
  );

  Quotes.fromJson(Map<String, dynamic> json)
    : lastUpdateTime =
          json["time_last_update"] ??
          DateTime.timestamp().toString(),
      nextUpdateTime =
          json["time_next_update"] ??
          DateTime.timestamp().toString(),
      rates = CurrencyRates(
        usd: json["rates"]["USD"] ?? 0,
        eur: json["rates"]["EUR"] ?? 0,
        cny: json["rates"]["CNY"] ?? 0,
        rub: json["rates"]["RUB"] ?? 0,
        usdParallel: json["rates"]["USD_PARALLEL"] ?? 0,
        btc: json["rates"]["BTC"] ?? 0,
        allValues: json["rates"]["allValues"] != null
            ? json["rates"]["allValues"].map(
                (key, value) => MapEntry(
                  key,
                  SupportedCurrency.fromJson(value),
                ),
              )
            : {},
      ),
      lastQuote = json["last_quote"] != null
          ? Quotes.fromJson(json["last_quote"])
          : null;

  Map<String, dynamic> toJson() {
    return {
      "time_last_update": lastUpdateTime,
      "time_next_update": nextUpdateTime,
      "rates": rates.allRates,
      "allValues": rates.allValues.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
      "last_quote": lastQuote?.toJson(),
    };
  }
}
