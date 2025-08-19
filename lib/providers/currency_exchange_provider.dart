import 'dart:convert';

import 'package:awesome_dolar_price/api/currency.dart';
import 'package:awesome_dolar_price/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:awesome_dolar_price/tokens/models/quotes.dart';
import 'package:awesome_dolar_price/tokens/models/currency_rates.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'currency_exchange_provider.g.dart';

@riverpod
class CurrencyExchangeNotifier extends _$CurrencyExchangeNotifier {
  @override
  Quotes build() {
    return getSavedDolarPrice() ??
        Quotes(
          lastUpdateTime: DateTime.timestamp().toString(),
          nextUpdateTime: DateTime.timestamp().toString(),
          rates: CurrencyRates(0, 0, 0, 0),
        );
  }

  Future<void> fetchPrices({bool forceUpdate = false}) async {
    /// Check if the saved price exist and
    /// the next update time is after the current date,

    switch (forceUpdate) {
      case true:
        state = await fetchNewPrices();
        await saveDolarPrice();
        break;
      default:
        var cache = validateCache();
        if (cache != null) {
          if (kDebugMode) {
            print("Using cache prices value");
          }
          state = cache;
          await saveDolarPrice();
        } else {
          state = await fetchNewPrices();
          await saveDolarPrice();
        }
    }

    /// If not, fetch normally

    await saveDolarPrice();
  }

  /// Returns the saved price only if the next update time is after the current time
  Quotes? validateCache() {
    Quotes? cachePrice = getSavedDolarPrice();

    if (cachePrice == null) return null;

    var nextUpdateTimeParsed =
        DateTime.parse(cachePrice.nextUpdateTime);
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
    var responses = await Future.wait([
      getCurrency("USD"),
      getCurrency("EUR"),
      getCurrency("CNY"),
      getCurrency("RUB"),
    ]);

    Map<String, double> rates = {};

    for (var res in responses) {
      rates[res["base_code"]] = res["rates"]["VES"].toDouble();
    }

    var result = Quotes(
      rates: CurrencyRates(
        rates["USD"]!,
        rates["EUR"]!,
        rates["CNY"]!,
        rates["RUB"]!,
      ),

      /// The api has its own time, but i decided to
      /// use custom caching
      lastUpdateTime: DateTime.timestamp().toString(),
      nextUpdateTime: DateTime.timestamp()
          .add(
            Duration(hours: 1),
          )
          .toString(),
    );

    return result;
  }

  Future<void> saveDolarPrice() async {
    return LocalStorage.setString(
      "dolar-price",
      JsonCodec().encode(
        state.toJson(),
      ),
    );
  }

  Quotes? getSavedDolarPrice() {
    String? dolarPrice = LocalStorage.getString("dolar-price");
    if (dolarPrice == null) {
      if (kDebugMode) {
        print("Theres no dolar price saved");
      }
      return null;
    }

    var json = JsonCodec().decode(dolarPrice);

    return Quotes.fromJson(json);
  }
}
