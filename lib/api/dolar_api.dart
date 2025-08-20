import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

enum Prices { official, parallel, bitcoin }

/// https://ve.dolarapi.com
abstract class DolarApi {
  static String baseUrl = "https://ve.dolarapi.com/v1";

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
      throw SocketException("Could not get official dolar price");
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
      throw SocketException("Could not get parallel dolar price");
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
  static Future<Map<String, dynamic>> getBitcoinPrice() async {
    try {
      final prices = await getAllPrices();
      return prices[Prices.bitcoin.index];
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
  static Future<List<dynamic>> getAllPrices() async {
    final response = await http.get(Uri.parse("$baseUrl/dolares"));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json;
    }
    throw SocketException("Could not get dolar price");
  }
}
