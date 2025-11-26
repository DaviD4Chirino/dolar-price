import 'package:doya/services/dolar_api/dolar_api_service.dart';
import 'package:doya/services/exchange_rate/exchange_rate_service.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/utils/utils.dart';

abstract class DolarUtils {
  static Future<List<SupportedCurrency>?>
  getSupportedCurrencies() async {
    List<SupportedCurrency> getAllPrices = [];

    try {
      final allProvidersResponse = await Future.wait([
        // * Insert here all the providers
        DolarApiService.getSupportedCurrencies(),
        ExchangeRateService.getSupportedCurrencies(),
      ]);

      if (allProvidersResponse.isEmpty) {
        return null;
      }

      for (var response in allProvidersResponse) {
        if (response == null) continue;
        getAllPrices.addAll(response);
      }
      return getAllPrices;
    } on Exception catch (e) {
      Utils.log(e);
    }
    return null;
  }
}
