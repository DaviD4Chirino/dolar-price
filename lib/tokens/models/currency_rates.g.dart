// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_rates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrencyRates _$CurrencyRatesFromJson(Map<String, dynamic> json) =>
    _CurrencyRates(
      rates: (json['rates'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, SupportedCurrency.fromJson(e as Map<String, dynamic>)),
      ),
      lastUpdateTime: (json['lastUpdateTime'] as num?)?.toInt(),
      nextUpdateTime: (json['nextUpdateTime'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CurrencyRatesToJson(_CurrencyRates instance) =>
    <String, dynamic>{
      'rates': instance.rates,
      'lastUpdateTime': instance.lastUpdateTime,
      'nextUpdateTime': instance.nextUpdateTime,
    };
