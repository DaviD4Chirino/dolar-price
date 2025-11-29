import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doya/tokens/utils/utils.dart';

enum Prices { official, parallel, bitcoin }

/// https://ve.dolarapi.com
abstract class DolarApi {
  static String baseUrl = "https://ve.dolarapi.com/v1";

  static Future<Map<String, dynamic>?> getPairConversion(
    String code, {
    bool earlyThrow = false,
  }) async {
    try {
      switch (code) {
        case "USD":
          final res = await getOfficialPrice();
          return res;
        case "USD_PARALLEL":
          final res = await getParallelPrice();
          return res;
        case "BTC":
          final res = await getBitcoinPrice();
          return res;
        default:
          throw Exception("Unknown currency code");
      }
    } catch (e) {
      Utils.log(e);
      return null;
    }
  }

  /// Example response:
  /// ```json
  /// {
  ///    "fuente": "oficial",
  ///    "nombre": "Oficial",
  ///    "compra": null,
  ///    "venta": null,
  ///    "promedio": 138.1283,
  ///    "fechaActualizacion": "2025-08-20T14:01:57.904Z",
  ///  }
  /// ```
  static Future<Map<String, dynamic>> getOfficialPrice() async {
    try {
      final prices = await getAllPrices();
      return prices[Prices.official.index];
    } catch (e) {
      throw SocketException(
        "Could not get official dolar price",
      );
    }
  }

  /// Example response:
  /// ```json
  /// {
  ///    "fuente": "paralelo",
  ///    "nombre": "Paralelo",
  ///    "compra": null,
  ///    "venta": null,
  ///    "promedio": 205.7,
  ///    "fechaActualizacion": "2025-08-20T14:02:01.594Z",
  ///  } ```
  static Future<Map<String, dynamic>> getParallelPrice() async {
    try {
      final prices = await getAllPrices();
      return prices[Prices.parallel.index];
    } catch (e) {
      throw SocketException(
        "Could not get parallel dolar price",
      );
    }
  }

  /// Example response:
  /// ```json
  /// {
  ///    "fuente": "bitcoin",
  ///    "nombre": "Bitcoin",
  ///    "compra": null,
  ///    "venta": null,
  ///    "promedio": 115.17,
  ///    "fechaActualizacion": "2025-08-20T14:01:57.904Z",
  ///  }
  /// ```
  static Future<Map<String, dynamic>> getBitcoinPrice({
    bool earlyThrow = false,
  }) async {
    if (earlyThrow) {
      throw SocketException("Early throw");
    }
    final dio = Dio();

    try {
      final response = await dio.get("$baseUrl/dolares/bitcoin");
      if (response.statusCode == 200) {
        return response.data;
      }
      throw SocketException(response.data["error"]);
    } catch (e) {
      throw SocketException("Could not get bitcoin dolar price");
    }
  }

  /// Example response:
  /// ```json
  /// [
  ///  {
  ///    "fuente": "oficial",
  ///    "nombre": "Oficial",
  ///    "compra": null,
  ///    "venta": null,
  ///    "promedio": 138.1283,
  ///    "fechaActualizacion": "2025-08-20T14:01:57.904Z",
  ///  },
  ///  {
  ///    "fuente": "paralelo",
  ///    "nombre": "Paralelo",
  ///    "compra": null,
  ///    "venta": null,
  ///    "promedio": 205.7,
  ///    "fechaActualizacion": "2025-08-20T14:02:01.594Z",
  ///  },
  ///  {
  ///    "fuente": "bitcoin",
  ///    "nombre": "Bitcoin",
  ///    "compra": null,
  ///    "venta": null,
  ///    "promedio": 115.17,
  ///    "fechaActualizacion": "2025-08-20T14:01:57.904Z",
  ///  },
  ///] ```
  static Future<List<dynamic>> getAllPrices({
    bool earlyThrow = false,
  }) async {
    if (earlyThrow) {
      throw SocketException("Early throw");
    }
    final dio = Dio();

    final response = await dio.get("$baseUrl/dolares");
    if (response.statusCode == 200) {
      return response.data;
    }
    throw SocketException("Could not get dolar price");
  }
}
