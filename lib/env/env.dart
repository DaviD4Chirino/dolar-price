import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: "keys.env", obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'EXCHANGE_RATES_API_KEY')
  static final String exchangeRatesKey = _Env.exchangeRatesKey;
}
