// ignore_for_file: dead_code

import 'package:doya/api/dolar_api.dart';
import 'package:doya/providers/selected_currencies_provider.dart';
import 'package:doya/services/dolar_api/dolar_api_service.dart';
import 'package:doya/services/exchange_rate/exchange_rate_service.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/constants/rate_source.dart';
import 'package:doya/tokens/utils/dolar/dolar_utils.dart';
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
          lastUpdateTime:
              DateTime.timestamp().millisecondsSinceEpoch,
          nextUpdateTime:
              DateTime.timestamp().millisecondsSinceEpoch,
          rates: CurrencyRates(rates: {}),
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

      // _updateMainCurrency();
    }
  }

  /// Returns the saved price only if the next update time is after the current time
  Quotes? validateCache() {
    Utils.log("Validating cache");
    var selectedCurrencies = ref.read(
      selectedCurrenciesProvider,
    );

    Quotes? cachePrice = getSavedExchangeValue();

    if (cachePrice == null) return null;

    // check if theres a change on the the selected currencies
    var selectedCurrenciesSet = selectedCurrencies
        .map((e) => e.code)
        .toSet();

    var priceSet = state.rates.rates.keys.toSet();

    var isCurrencySelectionUpdated = !setEquals(
      selectedCurrenciesSet,
      priceSet,
    );

    // if the selected currencies changes, we should not use the cache
    if (isCurrencySelectionUpdated) return null;

    final now = DateTime.now();

    var nextUpdateTimeParsed =
        DateTime.fromMillisecondsSinceEpoch(
          cachePrice.nextUpdateTime,
        );

    var isAfter = now.isAfter(nextUpdateTimeParsed);

    if (isAfter) return null;

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
      var supportedCurrencies =
          await DolarUtils.getSupportedCurrencies();

      if (supportedCurrencies == null) {
        throw Exception("Could not fetch supported currencies");
      }

      var selectedCurrencies = ref.read(
        selectedCurrenciesProvider,
      );

      List<Future<CurrencyRates?>> currencyFutures = [];

      // Fetching all supported currencies by their provider
      for (var currency in selectedCurrencies) {
        switch (currency.source) {
          case RateSource.dolarApi:
            currencyFutures.add(
              DolarApiService.getRate(currency),
            );
            break;
          case RateSource.exchangeRateApi:
            currencyFutures.add(
              ExchangeRateService.getRate(currency),
            );
            break;
          // This means is not defined yet
          case RateSource.none:
            break;
        }
      }

      var responses2 = await Future.wait<CurrencyRates?>(
        currencyFutures,
      );
      if (responses2.isEmpty) {
        throw Exception("Could not fetch any currency");
      }

      Map<String, SupportedCurrency> rates = {};

      // Note, there should not be duplicates
      for (var res in responses2) {
        if (res == null) continue;
        rates.addAll(res.rates);
      }

      int? lastUpdateTime = DateTime.now()
          .toUtc()
          .millisecondsSinceEpoch;
      int? nextUpdateTime =
          nextMidnightUtc().millisecondsSinceEpoch;

      newState = state.copyWith(
        rates: CurrencyRates(rates: rates),
        nextUpdateTime: nextUpdateTime,
        lastUpdateTime: lastUpdateTime,
        lastQuote: getPreviousExchangeValue(),
      );

      Utils.log("Dolar exchange api success");
      // _updateMainCurrency();

      return newState;
    } catch (e) {
      if (kDebugMode) {
        print(e);
        print('Both api failed, throwing');
        throw Exception("Could not fetch dolar prices");
      }
    }

    return state;
  }

  Future<Quotes> fetchDolarApiPrices({
    bool getOfficial = true,
  }) async {
    final dolarPrices = await DolarApi.getAllPrices();

    return Quotes(
      rates: CurrencyRates(
        rates: {
          "USD": getOfficial
              ? dolarPrices[Prices.official.index]["promedio"] ??
                    0
              : null,
          "USD_PARALLEL":
              dolarPrices[Prices.parallel.index]["promedio"] ??
              0,
        },
      ),
      nextUpdateTime: state.nextUpdateTime,
      lastUpdateTime: DateTime.parse(
        dolarPrices[Prices.parallel.index]["fechaActualizacion"],
      ).millisecondsSinceEpoch,
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

    //! Posible bug, maybe its from milliseconds instead of microseconds

    var filtered = quotes.where((q) {
      var lastUpdateTime = DateTime.fromMicrosecondsSinceEpoch(
        q.lastUpdateTime,
      );
      var nextUpdateTime = DateTime.fromMicrosecondsSinceEpoch(
        q.nextUpdateTime,
      );

      return lastUpdateTime.isBefore(nextUpdateTime) &&
          q.rates.getRate("USD") !=
              quotes.last.rates.getRate("USD");
    }).toList();
    filtered.sort((a, b) {
      var bLastUpdateTime = DateTime.fromMillisecondsSinceEpoch(
        b.lastUpdateTime,
      );
      var aLastUpdateTime = DateTime.fromMillisecondsSinceEpoch(
        a.nextUpdateTime,
      );

      return bLastUpdateTime.compareTo(aLastUpdateTime);
    });
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

DateTime nextMidnightUtc() {
  final nowUtc = DateTime.now().toUtc();
  // midnight for today in UTC, then +1 day -> next day's 00:00:00.000 UTC
  return DateTime.utc(
    nowUtc.year,
    nowUtc.month,
    nowUtc.day,
  ).add(const Duration(days: 1));
}
