import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Env {
  static String get exchangeRatesApiKey =>
      dotenv.env['EXCHANGE_RATES_API_KEY'] ?? 'NO KEY FOUND';
}
