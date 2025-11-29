import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:doya/tokens/constants/rate_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'supported_currency.freezed.dart';
part 'supported_currency.g.dart';

@freezed
abstract class SupportedCurrency with _$SupportedCurrency {
  const SupportedCurrency._();

  const factory SupportedCurrency({
    required String code,
    required String name,
    required RateSource source,
    @Default(0) double rate,
    String? symbol,
  }) = _SupportedCurrency;

  factory SupportedCurrency.fromExchangeRateApiList(
    List<dynamic> list,
  ) {
    return SupportedCurrency(
      source: RateSource.exchangeRateApi,
      code: list.first,
      name: list.last,
      symbol: getCurrencySymbol(list.first),
    );
  }

  factory SupportedCurrency.fromJson(
    Map<String, dynamic> json,
  ) => _$SupportedCurrencyFromJson(json);
}
