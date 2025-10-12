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

    var newQuotes = state.copyWith();

    try {
      var responses = await Future.wait<Map<String, dynamic>>([
        ExchangeRateApi.getCurrency("USD", earlyThrow: true),
        ExchangeRateApi.getCurrency("EUR"),
      ]);

      Map<String, double> rates = {};

      for (var res in responses) {
        rates[res["base_code"]] = res["conversion_rates"]["VES"]
            .toDouble();
      }
      final dolarApiPrices = await fetchDolarApiPrices();

      newQuotes = newQuotes.copyWith(
        rates: CurrencyRates(
          usd: rates["USD"] ?? 0,
          eur: rates["EUR"] ?? 0,
          usdParallel: dolarApiPrices.usdParallel,
          btc: dolarApiPrices.btc,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
        print('Dolar exchange api failed, trying dolar api');
      }

      try {
        final dolarApiPrices = await fetchDolarApiPrices();
        newQuotes = newQuotes.copyWith(
          rates: CurrencyRates(
            usd: dolarApiPrices.usd,
            usdParallel: dolarApiPrices.usdParallel,
            btc: dolarApiPrices.btc,
          ),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
          print('Dolar api failed, Throwing');
        }
        // if both fails, better to do nothing
        throw Exception("Could not fetch dolar prices");
      }
    }

    final lastUpdateTime = DateTime.timestamp().toString();
    final nextUpdateTime =
        DateTime.timestamp() /* .add(Duration(hours: 1))*/
            .toString();

    state = newQuotes.copyWith(
      lastUpdateTime: lastUpdateTime,
      nextUpdateTime: nextUpdateTime,
      lastQuote: getPreviousExchangeValue(),
    );

    // var allPrices = await DolarApi.getAllPrices();

    // var result = state.copyWith(
    //   rates: CurrencyRates(
    //     usdParallel:
    //         allPrices[Prices.parallel.index]["promedio"] ?? 0,
    //     btc: allPrices[Prices.bitcoin.index]["promedio"] ?? 0,
    //   ),

    //   /// So we can compare the current value with the previous one
    //   lastQuote: getPreviousExchangeValue(),

    //   /// The api has its own time, but i decided to
    //   /// use custom caching
    //   lastUpdateTime: lastUpdateTime,
    //   nextUpdateTime: nextUpdateTime,
    // );

    return state;
  }

  Future<CurrencyRates> fetchDolarApiPrices({
    bool getOfficial = true,
  }) async {
    final dolarPrices = await DolarApi.getAllPrices();

    return CurrencyRates(
      usd: getOfficial
          ? dolarPrices[Prices.official.index]["promedio"] ?? 0
          : null,
      usdParallel:
          dolarPrices[Prices.parallel.index]["promedio"] ?? 0,
      btc: dolarPrices[Prices.bitcoin.index]["promedio"] ?? 0,
    );
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
