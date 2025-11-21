import 'package:doya/api/dolar_api.dart';
import 'package:doya/api/exchange_rate_api.dart';
import 'package:doya/providers/main_currency_provider.dart';
import 'package:doya/tokens/models/currencies.dart';
import 'package:doya/tokens/utils/helpers/quotes_helper.dart';
import 'package:doya/tokens/models/quotes.dart';
import 'package:doya/tokens/models/currency_rates.dart';
import 'package:doya/tokens/utils/utils.dart';
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

  Future<void> updateUsingDolarApi() async {
    Utils.log("Updating with dolar api only");
    final dolarApiPrices = await fetchDolarApiPrices();
    state = state.copyWith(
      rates: state.rates.copyWith(
        usd: dolarApiPrices.rates.usd,
        usdParallel: dolarApiPrices.rates.usdParallel,
        btc: dolarApiPrices.rates.btc,
      ),
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

    final now = DateTime.now();

    var nextUpdateTimeParsed = DateTime.parse(
      cachePrice.nextUpdateTime,
    );

    var isAfter = now.isAfter(nextUpdateTimeParsed);

    if (isAfter) {
      return null;
    }
    if (kDebugMode) {
      print(
        "Next prices update time is before the current time",
      );
    }
    return cachePrice;
  }

  Future<Quotes> fetchNewPrices() async {
    if (kDebugMode) {
      print("fetching new prices");
    }

    var newState = state.copyWith();

    try {
      var responses = await Future.wait<Map<String, dynamic>?>([
        ExchangeRateApi.getPairConversion("USD"),
        ExchangeRateApi.getPairConversion("EUR"),
      ]);

      Map<String, double> rates = {};

      for (var res in responses) {
        if (res == null) continue;
        rates[res["base_code"]] = res["conversion_rate"]
            .toDouble();
      }
      Quotes? dolarApiPrices;

      try {
        dolarApiPrices = await fetchDolarApiPrices();
      } catch (e) {
        if (kDebugMode) {
          print(e);
          print('Dolar api failed, Using Dolar exchange api');
        }
      }

      int? lastUpdateTime;
      int? nextUpdateTime;

      if (responses.isNotEmpty && responses.first != null) {
        lastUpdateTime =
            responses.first!["time_last_update_unix"];
        nextUpdateTime =
            responses.first!["time_next_update_unix"];
      }

      newState = state.copyWith(
        rates: CurrencyRates(
          usd: rates["USD"] ?? dolarApiPrices?.rates.usd ?? 0,
          eur: rates["EUR"] ?? dolarApiPrices?.rates.eur ?? 0,
          usdParallel: dolarApiPrices?.rates.usdParallel ?? 0,
          btc: dolarApiPrices?.rates.btc ?? 0,
        ),
        nextUpdateTime: nextUpdateTime != null
            ? DateTime.fromMillisecondsSinceEpoch(
                nextUpdateTime * 1000,
                isUtc: true,
              ).toString()
            : null,
        lastUpdateTime: lastUpdateTime != null
            ? DateTime.fromMillisecondsSinceEpoch(
                lastUpdateTime * 1000,
                isUtc: true,
              ).toString()
            : null,
        lastQuote: getPreviousExchangeValue(),
      );
      Utils.log("Dolar exchange api success");
      _changeMainCurrency(Currencies.usd);
      return newState;
    } catch (e) {
      if (kDebugMode) {
        print(e);
        print('Both api failed, throwing');
        throw Exception("Could not fetch dolar prices");
      }

      /* try {
        final dolarApiPrices = await fetchDolarApiPrices();
        var prevQuotes = getPreviousExchangeValue();
        state = state.copyWith(
          rates: CurrencyRates(
            usd: dolarApiPrices.rates.usd,
            usdParallel: dolarApiPrices.rates.usdParallel,
            btc: dolarApiPrices.rates.btc,
            eur: prevQuotes?.rates.eur ?? 0,
          ),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
          print('Dolar api failed, Throwing');
        }
        // if both fails, better to do nothing
        throw Exception("Could not fetch dolar prices");
      } */
    }
    /* Utils.log("Dolar exchange api failed, trying dolar api");

    final now = DateTime.now();

    final lastUpdateTime = DateTime.timestamp().toString();

    final nextUpdateTime = now
        .add(Duration(hours: 1))
        .toString();

    state = state.copyWith(
      lastUpdateTime: lastUpdateTime,
      nextUpdateTime: nextUpdateTime,
      lastQuote: getPreviousExchangeValue(),
    );

     */

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

  void _changeMainCurrency(String newCurrency) {
    final mainCurrency = ref.read(mainCurrencyProvider);

    final mainCurrencyNotifier = ref.read(
      mainCurrencyProvider.notifier,
    );

    if (state.rates.getRate(mainCurrency) == 0) {
      mainCurrencyNotifier.setMainCurrency(Currencies.usd);
    }
  }

  Future<Quotes> fetchDolarApiPrices({
    bool getOfficial = true,
  }) async {
    final dolarPrices = await DolarApi.getAllPrices();

    return Quotes(
      rates: CurrencyRates(
        usd: getOfficial
            ? dolarPrices[Prices.official.index]["promedio"] ?? 0
            : null,
        usdParallel:
            dolarPrices[Prices.parallel.index]["promedio"] ?? 0,
        btc: /* dolarPrices[Prices.bitcoin.index]["promedio"] ??
        ! btc is not available
         */
            0,
      ),
      nextUpdateTime: state.nextUpdateTime,
      lastUpdateTime: DateTime.parse(
        dolarPrices[Prices.parallel.index]["fechaActualizacion"],
      ).toIso8601String(),
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
