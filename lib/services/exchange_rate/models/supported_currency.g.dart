// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supported_currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SupportedCurrency _$SupportedCurrencyFromJson(Map<String, dynamic> json) =>
    _SupportedCurrency(
      code: json['code'] as String,
      name: json['name'] as String,
      source: $enumDecode(_$RateSourceEnumMap, json['source']),
      rate: (json['rate'] as num?)?.toDouble() ?? 0,
      symbol: json['symbol'] as String?,
    );

Map<String, dynamic> _$SupportedCurrencyToJson(_SupportedCurrency instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'source': _$RateSourceEnumMap[instance.source]!,
      'rate': instance.rate,
      'symbol': instance.symbol,
    };

const _$RateSourceEnumMap = {
  RateSource.none: 'none',
  RateSource.dolarApi: 'dolarApi',
  RateSource.exchangeRateApi: 'exchangeRateApi',
};
