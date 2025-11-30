import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';

abstract class Currencies {
  static String usd = "USD";
  static String eur = "EUR";
  // static String cny = "CNY";
  // static String rub = "RUB";
  static String usdParallel = "USD_PARALLEL";
  static String btc = "BTC";

  static String getCurrencyTitle(
    SupportedCurrency supportedCurrency, {
    // BuildContext? context,
    bool withoutSymbol = false,
  }) {
    return "${withoutSymbol ? "" : "${supportedCurrency.symbol}} "}${supportedCurrency.name}";
  }

  static String getSymbol(String currency) {
    if (currency case "USD_PARALLEL") {
      return "\$";
    } else if (currency case "BTC") {
      return "₿";
    } else {
      return getCurrencySymbol(currency);
    }
  }

  /* static String getCurrency(String currency) {
    switch (currency) {
      case "USD":
        return usd;
      case "EUR":
        return eur;
      // case "CNY":
      // return cny;
      // case "RUB":
      // return rub;
      case "USD_PARALLEL":
        return usdParallel;
      case "BTC":
        return btc;
      default:
        throw Exception("Currency not found");
    }
  } */

  static bool isCurrency(String currency) {
    return currency == usd ||
        currency == eur ||
        // currency == cny ||
        // currency == rub ||
        currency == usdParallel ||
        currency == btc;
  }

  static List<String> allCurrencies = [
    usd,
    usdParallel,
    eur,
    // cny,
    // rub,
    btc,
  ];
}
