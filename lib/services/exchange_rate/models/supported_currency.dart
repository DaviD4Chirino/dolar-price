import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:doya/tokens/constants/rate_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

part 'supported_currency.freezed.dart';
part 'supported_currency.g.dart';

@freezed
abstract class SupportedCurrency with _$SupportedCurrency {
  const SupportedCurrency._();

  const factory SupportedCurrency({
    required String code,
    required String name,
    @JsonKey(defaultValue: RateSource.none)
    required RateSource source,
    @Default(0) double rate,
    String? symbol,
  }) = _SupportedCurrency;

  String formattedRate({bool withSymbol = true}) {
    return Money.fromNum(
      rate,
      isoCode: "VES",
    ).format(withSymbol ? r'0.00 S' : r'0.00');
  }

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
