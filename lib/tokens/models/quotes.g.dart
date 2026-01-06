// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Quotes _$QuotesFromJson(Map<String, dynamic> json) => _Quotes(
  lastUpdateTime: (json['lastUpdateTime'] as num).toInt(),
  nextUpdateTime: (json['nextUpdateTime'] as num).toInt(),
  rates: CurrencyRates.fromJson(json['rates'] as Map<String, dynamic>),
  lastQuote: json['lastQuote'] == null
      ? null
      : Quotes.fromJson(json['lastQuote'] as Map<String, dynamic>),
);

Map<String, dynamic> _$QuotesToJson(_Quotes instance) => <String, dynamic>{
  'lastUpdateTime': instance.lastUpdateTime,
  'nextUpdateTime': instance.nextUpdateTime,
  'rates': instance.rates,
  'lastQuote': instance.lastQuote,
};
