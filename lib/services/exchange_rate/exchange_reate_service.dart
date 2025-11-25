import 'package:doya/api/exchange_rate_api.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/utils/utils.dart';

abstract class ExchangeRateService {
  static Future<List<SupportedCurrency>?>
  getSupportedCurrencies() async {
    try {
      final response =
          await ExchangeRateApi.getSupportedCurrencies();

      if (response == null) return null;

      final List<dynamic>? supportedCurrencies =
          response["supported_codes"];

      if (supportedCurrencies == null) return null;

      final List<SupportedCurrency> supportedCurrenciesList =
          supportedCurrencies
              .map((e) => SupportedCurrency.fromList(e))
              .toList();
      return supportedCurrenciesList;
    } catch (e) {
      Utils.log(e);
      rethrow;
    }
  }
}
