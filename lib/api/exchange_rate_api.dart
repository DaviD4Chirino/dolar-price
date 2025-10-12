import 'dart:convert';
import 'dart:io';

import 'package:doya/tokens/constants/env.dart';
import 'package:http/http.dart' as http;

// TODO: So, if we have multiple apis, we need to switch from them, so, uh do that
abstract class ExchangeRateApi {
  static Future<Map<String, dynamic>> getCurrency(
    String code, {
    DateTime? date,
    bool earlyThrow = false,
  }) async {
    if (earlyThrow) {
      throw SocketException("Early throw");
    }

    String url = "";

    if (date != null && date.isAfter(DateTime(2021))) {
      final year = date.year;
      final month = date.month;
      final day = date.day;
      url =
          "https://v6.exchangerate-api.com/v6/${Env.exchangeRatesApiKey}/history/$code/$year/$month/$day";
    } else {
      url =
          "https://v6.exchangerate-api.com/v6/${Env.exchangeRatesApiKey}/latest/$code";
    }

    final response = await http.get(
      // I had no idea this api existed, i was planning on scrapping https://www.bcv.org.ve
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json["result"] == "error") {
        throw SocketException(
          "Api Error: ${json["error-type"]}",
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
    throw SocketException("Could not get dolar price");
  }

  //{"result":"error","documentation":"https://www.exchangerate-api.com/docs","terms-of-use":"https://www.exchangerate-api.com/terms","error-type":"plan-upgrade-required"}
}
