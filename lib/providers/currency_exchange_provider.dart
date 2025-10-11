import 'package:doya/api/dolar_api.dart';
import 'package:doya/api/exchange_rate_api.dart';
import 'package:doya/tokens/utils/helpers/quotes_helper.dart';
import 'package:doya/tokens/models/quotes.dart';
import 'package:doya/tokens/models/currency_rates.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'currency_exchange_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrencyExchangeNotifier
    extends _$CurrencyExchangeNotifier {
  @override
  Quotes build() {
    return getSavedExchangeValue() ??
        Quotes(
          lastUpdateTime: DateTime.timestamp().toString(),
          nextUpdateTime: DateTime.timestamp().toString(),
          rates: CurrencyRates(),
        );
  }

  Future<void> fetchPrices({bool forceUpdate = false}) async {
    /// Check if the saved price exist and
    /// the next update time is after the current date,

    switch (forceUpdate) {
      case true:
        state = await fetchNewPrices();
        await saveExchangeValue();
        break;
      default:
        var cache = validateCache();
        if (cache != null) {
          if (kDebugMode) {
            print("Using cache prices value");
          }
          state = cache;
        } else {
          state = await fetchNewPrices();
          await saveExchangeValue();
        }
    }
  }

  /// Returns the saved price only if the next update time is after the current time
  Quotes? validateCache() {
    Quotes? cachePrice = getSavedExchangeValue();

    if (cachePrice == null) return null;

    var nextUpdateTimeParsed = DateTime.parse(
      cachePrice.nextUpdateTime,
    );
    var now = DateTime.now();
    var isAfter = nextUpdateTimeParsed.isAfter(now);

    if (!isAfter) {
      if (kDebugMode) {
        print(
          "Next prices update time is before the current time",
        );
      }
      return null;
    }

    return cachePrice;
  }

  Future<Quotes> fetchNewPrices() async {
    if (kDebugMode) {
      print("fetching new prices");
    }
    try {} catch (e) {

    }

    var responses = await Future.wait([
      ExchangeRateApi.getCurrency("USD"),
      ExchangeRateApi.getCurrency("EUR"),
      ExchangeRateApi.getCurrency("CNY"),
      ExchangeRateApi.getCurrency("RUB"),
    ]);

    Map<String, double> rates = {};

    for (var res in responses) {
      rates[res["base_code"]] = res["conversion_rates"]["VES"]
          .toDouble();
    }
    var allPrices = await DolarApi.getAllPrices();

    var result = Quotes(
      rates: CurrencyRates(
        usd: rates["USD"]!,
        usdParallel:
            allPrices[Prices.parallel.index]["promedio"]!,
        btc: allPrices[Prices.bitcoin.index]["promedio"]!,
        eur: rates["EUR"]!,
        cny: rates["CNY"]!,
        rub: rates["RUB"]!,
      ),

      /// So we can compare the current value with the previous one
      lastQuote: getPreviousExchangeValue(),

      /// The api has its own time, but i decided to
      /// use custom caching
      lastUpdateTime: DateTime.timestamp().toString(),
      nextUpdateTime: DateTime.timestamp()
          .add(Duration(hours: 1))
          .toString(),
    );

    return result;
  }

  Future<void> saveExchangeValue() async {
    return saveQuote(state);
  }

  Quotes? getSavedExchangeValue() {
    var quotes = getQuotes();
    if (quotes == null || quotes.isEmpty) {
      return null;
    }
    return quotes.last;
  }

  Quotes? getPreviousExchangeValue() {
    var quotes = getQuotes();
    if (quotes == null || quotes.isEmpty) {
      return null;
    }
    if (quotes.length <= 1) {
      return null;
    }

    var filtered = quotes
        .where(
          (q) =>
              DateTime.parse(q.lastUpdateTime).isBefore(
                DateTime.parse(quotes.last.lastUpdateTime),
              ) &&
              q.rates.getRate("USD") !=
                  quotes.last.rates.getRate("USD"),
        )
        .toList();
    filtered.sort(
      (a, b) => DateTime.parse(
        b.lastUpdateTime,
      ).compareTo(DateTime.parse(a.lastUpdateTime)),
    );
    if (filtered.isEmpty) {
      return null;
    }
    return filtered.first;
  }

  void updatePreviousExchangeValue() {
    var quote = getPreviousExchangeValue();
    if (quote == null) {
      return;
    }
    var newState = Quotes(
      lastQuote: quote,
      lastUpdateTime: state.lastUpdateTime,
      nextUpdateTime: state.nextUpdateTime,
      rates: state.rates,
    );
    state = newState;
  }
}
