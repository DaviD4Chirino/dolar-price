import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:flutter/material.dart';

abstract class Currencies {
  static String usd = "USD";
  static String eur = "EUR";
  static String cny = "CNY";
  static String rub = "RUB";
  static String usdParallel = "USD_PARALLEL";
  static String btc = "BTC";

  static String getCurrencyTitle(
    String currency, {
    BuildContext? context,
    bool withoutSymbol = false,
  }) {
    var symbol = withoutSymbol ? "" : "${getSymbol(currency)} ";

    switch (currency) {
      case "USD":
        if (context != null) {
          var t = AppLocalizations.of(context);
          return "$symbol${t.currencyDolar}";
        }
        return "${symbol}USD Dolar";
      case "EUR":
        return "${symbol}Euro";
      case "CNY":
        return "${symbol}Yuan";
      case "RUB":
        if (context != null) {
          var t = AppLocalizations.of(context);
          return "$symbol${t.currencyRuble}";
        }
        return "${symbol}Ruble";

      case "USD_PARALLEL":
        if (context != null) {
          var t = AppLocalizations.of(context);
          var symbol_ = withoutSymbol ? "" : "\$ ";
          return "$symbol_${t.currencyParallel}";
        }
        return "${symbol}Parallel Dolar";
      case "BTC":
        return "${withoutSymbol ? "" : "₿ "}Bitcoin";
      default:
        throw Exception("Currency not found");
    }
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
    usdParallel,
    eur,
    cny,
    rub,
    btc,
  ];
}
