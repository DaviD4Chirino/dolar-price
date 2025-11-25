// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supported_currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SupportedCurrency _$SupportedCurrencyFromJson(Map<String, dynamic> json) =>
    _SupportedCurrency(
      code: json['code'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String?,
    );

Map<String, dynamic> _$SupportedCurrencyToJson(_SupportedCurrency instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
    };
