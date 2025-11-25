import 'package:freezed_annotation/freezed_annotation.dart';

part 'supported_currency.freezed.dart';
part 'supported_currency.g.dart';

@freezed
abstract class SupportedCurrency with _$SupportedCurrency {
  const SupportedCurrency._();

  const factory SupportedCurrency({
    required String code,
    required String name,
  }) = _SupportedCurrency;

  factory SupportedCurrency.fromList(List<dynamic> list) {
    return SupportedCurrency(code: list.first, name: list.last);
  }

  factory SupportedCurrency.fromJson(
    Map<String, dynamic> json,
  ) => _$SupportedCurrencyFromJson(json);
}
