import 'dart:convert';

import 'package:awesome_dolar_price/api/currency.dart';
import 'package:awesome_dolar_price/tokens/local_storage.dart';
import 'package:awesome_dolar_price/tokens/models/currency_exchange.dart';
import 'package:awesome_dolar_price/tokens/models/currency_rates.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dolar_price.g.dart';

@riverpod
class DolarPriceNotifier extends _$DolarPriceNotifier {
  @override
  CurrencyExchange build() {
    return getSavedDolarPrice() ??
        CurrencyExchange(
          lastUpdateTime: DateTime.utc(2020),
          nextUpdateTime: DateTime.utc(2030),
          rates: CurrencyRates(0, 0, 0, 0),
        );
  }

  Future<void> fetchPrices({bool forceUpdate = false}) async {
    /// Check if the saved price exist and
    /// the next update time is after the current date,

    if (!forceUpdate) {
      CurrencyExchange? cachePrice = getSavedDolarPrice();
      if (cachePrice != null) {
        if (!cachePrice.nextUpdateTime.isAfter(DateTime.now())) {
          if (kDebugMode) {
            print("Using cache value");
          }
          state = cachePrice;
          return;
        }
      }
    }

    /// If not, fetch normally

    if (kDebugMode) {
      print("fetching new value");
    }
    var responses = await Future.wait([
      getCurrency("USD"),
      getCurrency("EUR"),
      getCurrency("CNY"),
      getCurrency("RUB"),
    ]);

    Map<String, double> rates = {};

    for (var res in responses) {
      rates[res["base_code"]] = res["rates"]["VES"];
    }

    state = CurrencyExchange(
      rates: CurrencyRates(
        rates["USD"]!,
        rates["EUR"]!,
        rates["CNY"]!,
        rates["RUB"]!,
      ),
      lastUpdateTime: DateTime.fromMicrosecondsSinceEpoch(
        responses.last["time_last_update_unix"],
        // isUtc: true,
      ),
      nextUpdateTime: DateTime.fromMicrosecondsSinceEpoch(
        responses.last["time_next_update_unix"],
        // isUtc: true,
      ),
    );
    await saveDolarPrice();
  }

  Future<void> saveDolarPrice() async {
    return LocalStorage.setString(
        "dolar-price", JsonCodec().encode(state.toJson()));
  }

  CurrencyExchange? getSavedDolarPrice() {
    String? dolarPrice = LocalStorage.getString("dolar-price");
    if (dolarPrice == null) return null;

    var json = JsonCodec().decode(dolarPrice);

    return CurrencyExchange.fromJson(json);
  }
}
