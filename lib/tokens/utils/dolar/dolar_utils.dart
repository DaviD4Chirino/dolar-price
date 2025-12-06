import 'dart:convert';

import 'package:doya/services/dolar_api/dolar_api_service.dart';
import 'package:doya/services/exchange_rate/exchange_rate_service.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:doya/tokens/utils/modules/local_storage/models/local_storage_paths.dart';
import 'package:doya/tokens/utils/utils.dart';

abstract class DolarUtils {
  /// Fetch supported currencies from all providers, flatten into a single-level list,
  /// and deduplicate by currency code (case-insensitive).
  ///
  /// When the same currency code appears in multiple providers, the first occurrence
  /// (the oldest as encountered by the provider order and list order) is kept.
  static Future<List<SupportedCurrency>?>
  getSupportedCurrencies() async {
    final List<SupportedCurrency> flattened = [];
    final Set<String> seenCodes = {};
    var now = DateTime.now();

    /* final savedSupportedCurrenciesDate = LocalStorage.getInt(
      LocalStoragePaths.supportedCurrenciesDate,
    );

    if (savedSupportedCurrenciesDate != null || false) {
      bool isExpired = now.isAfter(
        DateTime.fromMillisecondsSinceEpoch(
          savedSupportedCurrenciesDate,
        ),
      );
      final savedSupportedCurrencies =
          LocalStorage.getStringList(
            LocalStoragePaths.supportedCurrencies,
          );

      if (savedSupportedCurrencies != null && !isExpired) {
        final List<SupportedCurrency> supportedCurrenciesList =
            savedSupportedCurrencies
                .map(
                  (e) =>
                      SupportedCurrency.fromJson(jsonDecode(e)),
                )
                .toList();
        return supportedCurrenciesList;
      }
    } */

    try {
      final providers = [
        // * Insert here all the providers
        ExchangeRateService.getSupportedCurrencies(),
        DolarApiService.getSupportedCurrencies(),
      ];
      List<List<SupportedCurrency>> allProvidersResponse = [];
      Utils.log(await DolarApiService.getSupportedCurrencies());

      for (var provider in providers) {
        try {
          final supportedCurrencies = await provider;
          if (supportedCurrencies == null) continue;
          allProvidersResponse.add(supportedCurrencies);
        } catch (e) {
          Utils.log(e);
        }
      }

      if (allProvidersResponse.isEmpty) {
        return null;
      }

      for (var response in allProvidersResponse) {
        for (var item in response) {
          if (seenCodes.add(item.code)) {
            flattened.add(item);
          }
        }
      }

      // Save the list to local storage
      // And set the expiration date to 30 days from now
      await Future.wait([
        LocalStorage.setStringList(
          LocalStoragePaths.supportedCurrencies,
          flattened.map((e) => jsonEncode(e.toJson())).toList(),
        ),
        LocalStorage.setInt(
          LocalStoragePaths.supportedCurrenciesDate,
          now.add(Duration(days: 30)).millisecondsSinceEpoch,
        ),
      ]);

      return flattened;
    } on Exception catch (e) {
      Utils.log(e);
    }

    return null;
  }

  static List<SupportedCurrency>? getSelectedCurrencies() {
    var savedSupportedCurrencies = LocalStorage.getStringList(
      LocalStoragePaths.supportedCurrencies,
    );
    if (savedSupportedCurrencies == null) return null;

    var supportedCurrencies = savedSupportedCurrencies
        .map((e) => SupportedCurrency.fromJson(jsonDecode(e)))
        .toList();

    return supportedCurrencies;
  }
}
