import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doya/tokens/constants/env.dart';
import 'package:flutter/foundation.dart';

// TODO: So, if we have multiple apis, we need to switch from them, so, uh do that
abstract class ExchangeRateApi {
  static final Dio dio = Dio();

  static final apiKeys = [
    Env.exchangeRatesApiKey,
    Env.exchangeRatesApiKey2,
    Env.exchangeRatesApiKey3,
  ];

  static Future<Map<String, dynamic>> getCurrency(
    String code, {
    DateTime? date,
    bool earlyThrow = false,
    int apiKeyIndex = 0,
  }) async {
    if (apiKeyIndex > apiKeys.length) {
      if (kDebugMode) {
        print("Api key index out of range");
      }
      throw SocketException("Could not get dolar price");
    }

    try {
      if (earlyThrow) {
        throw SocketException("Early throw");
      }
      String url = "";
      String apiKey = apiKeys[apiKeyIndex];
      if (date != null && date.isAfter(DateTime(2021))) {
        final year = date.year;
        final month = date.month;
        final day = date.day;
        url =
            "https://v6.exchangerate-api.com/v6/$apiKey/history/$code/$year/$month/$day";
      } else {
        url =
            "https://v6.exchangerate-api.com/v6/$apiKey/latest/$code";
      }

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final json = response.data;
        if (json["result"] == "error") {
          throw SocketException(
            "Api Error: ${json["error-type"]}",
          );
        }
        if (kDebugMode) {
          print(
            "Successfully got dolar price at level $apiKeyIndex",
          );
        }
        return json;
      }
      if (response.statusCode == 403) {
        final json = response.data;
        if (json["result"] == "error") {
          throw SocketException(
            "Api Error: ${json["error-type"]}",
          );
        }
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return getCurrency(
        code,
        date: date,
        earlyThrow: earlyThrow,
        apiKeyIndex: apiKeyIndex + 1,
      );
    }
    // I feel like this will be called 3 times
    throw SocketException("Could not get dolar price");
  }

  static Future<Map<String, dynamic>?> getPairConversion(
    String from, {
    String to = "VES",
    bool earlyExit = false,
    int apiKeyIndex = 0,
  }) async {
    if (apiKeyIndex >= apiKeys.length - 1) {
      if (kDebugMode) {
        print("Api key index out of range");
      }
      return null;
    }

    var apiKey = apiKeys[apiKeyIndex];
    var url =
        "https://v6.exchangerate-api.com/v6/$apiKey/pair/$from/$to";

    try {
      if (earlyExit) {
        throw Exception(
          "Early Exit with api key level $apiKeyIndex",
        );
      }
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final json = response.data;
        if (json["result"] == "error") {
          if (kDebugMode) {
            print("Api Error: ${json["error-type"]}");
          }
          return null;
        }

        if (kDebugMode) {
          print("success at api key level $apiKeyIndex");
        }
        return json;
      }
      if (response.statusCode == 403) {
        final json = response.data;
        if (json["result"] == "error") {
          if (kDebugMode) {
            print("Api Error: ${json["error-type"]}");
          }
          return null;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return getPairConversion(
        from,
        to: to,
        earlyExit: earlyExit,
        apiKeyIndex: apiKeyIndex + 1,
      );
    }
    return null;
  }

  /// Example response:
  /// ```json
  /// {
  ///	"result":"success",
  ///	"documentation":"https://www.exchangerate-api.com/docs",
  ///	"terms_of_use":"https://www.exchangerate-api.com/terms"
  ///	"supported_codes":[
  ///		["AED","UAE Dirham"],
  ///		etc, etc,
  ///	]
  ///}```
  static Future<Map<String, dynamic>?> getSupportedCurrencies({
    bool earlyThrow = false,
    int apiKeyIndex = 0,
  }) async {
    final apiKey = apiKeys[apiKeyIndex];
    final url =
        "https://v6.exchangerate-api.com/v6/$apiKey/codes";
    try {
      if (earlyThrow) {
        throw Exception(
          "Early Exit with api key level $apiKeyIndex",
        );
      }
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final json = response.data;
        if (json["result"] == "error") {
          if (kDebugMode) {
            print("Api Error: ${json["error-type"]}");
          }
          return null;
        }

        if (kDebugMode) {
          print("success at api key level $apiKeyIndex");
        }
        return json;
      }
      if (response.statusCode == 403) {
        final json = response.data;
        if (json["result"] == "error") {
          if (kDebugMode) {
            print("Api Error: ${json["error-type"]}");
          }
          return null;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return getSupportedCurrencies(
        earlyThrow: earlyThrow,
        apiKeyIndex: apiKeyIndex + 1,
      );
    }
    return null;
  }

  //{"result":"error","documentation":"https://www.exchangerate-api.com/docs","terms-of-use":"https://www.exchangerate-api.com/terms","error-type":"plan-upgrade-required"}
}
