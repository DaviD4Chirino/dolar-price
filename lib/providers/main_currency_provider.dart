import 'package:awesome_dolar_price/tokens/models/currencies.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_currency_provider.g.dart';

/// Use this to change the main currency,
/// Use [Currencies] to compare the currency
@Riverpod(keepAlive: true)
class MainCurrencyNotifier extends _$MainCurrencyNotifier {
  @override
  String build() {
    return Currencies.usd;
  }

  void setMainCurrency(String currency) {
    if (!Currencies.isCurrency(currency)) {
      throw Exception("$currency Is not a valid currency");
    }
    state = currency;
  }
}
