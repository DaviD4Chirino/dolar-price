import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Env {
  static String get exchangeRatesApiKey =>
      dotenv.env['EXCHANGE_RATES_API_KEY'] ?? 'NO KEY FOUND';
  static String get exchangeRatesApiKey2 =>
      dotenv.env['EXCHANGE_RATES_API_KEY_2'] ?? 'NO KEY FOUND';
  static String get exchangeRatesApiKey3 =>
      dotenv.env['EXCHANGE_RATES_API_KEY_3'] ?? 'NO KEY FOUND';
}
