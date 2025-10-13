import 'dart:convert';
import 'dart:io';

import 'package:doya/tokens/constants/env.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// TODO: So, if we have multiple apis, we need to switch from them, so, uh do that
abstract class ExchangeRateApi {
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
    if (earlyThrow) {
      throw SocketException("Early throw");
    }
    if (apiKeyIndex > apiKeys.length) {
      if (kDebugMode) {
        print("Api key index out of range");
      }
      throw SocketException("Could not get dolar price");
    }

    try {
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

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
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
        final json = jsonDecode(response.body);
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

  //{"result":"error","documentation":"https://www.exchangerate-api.com/docs","terms-of-use":"https://www.exchangerate-api.com/terms","error-type":"plan-upgrade-required"}
}
