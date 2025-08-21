import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';

abstract class Currencies {
  static String usd = "USD";
  static String eur = "EUR";
  static String cny = "CNY";
  static String rub = "RUB";
  static String usdParallel = "USD_PARALLEL";
  static String btc = "BTC";

  static String getCurrencyTitle(String currency) {
    switch (currency) {
      case "USD":
        return "${getCurrencySymbol(currency)} USD Dolar";
      case "EUR":
        return "${getCurrencySymbol(currency)} Euro";
      case "CNY":
        return "${getCurrencySymbol(currency)} Yuan";
      case "RUB":
        return "${getCurrencySymbol(currency)} Ruble";
      case "USD_PARALLEL":
        return "${getCurrencySymbol("USD")} Parallel Dolar";
      case "BTC":
        return "Bitcoin";
      default:
        throw Exception("Currency not found");
    }
  }

  static String getCurrency(String currency) {
    switch (currency) {
      case "USD":
        return usd;
      case "EUR":
        return eur;
      case "CNY":
        return cny;
      case "RUB":
        return rub;
      case "USD_PARALLEL":
        return usdParallel;
      case "BTC":
        return btc;
      default:
        throw Exception("Currency not found");
    }
  }

  static bool isCurrency(String currency) {
    return currency == usd ||
        currency == eur ||
        currency == cny ||
        currency == rub ||
        currency == usdParallel ||
        currency == btc;
  }

  static List<String> allCurrencies = [
    usd,
    eur,
    cny,
    rub,
    usdParallel,
    btc,
  ];
}
