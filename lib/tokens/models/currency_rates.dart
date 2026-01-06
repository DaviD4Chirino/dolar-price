import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'currency_rates.g.dart';
part 'currency_rates.freezed.dart';

@freezed
abstract class CurrencyRates with _$CurrencyRates {
  const CurrencyRates._();

  const factory CurrencyRates({
    required Map<String, SupportedCurrency> rates,
    int? lastUpdateTime,
    int? nextUpdateTime,
  }) = _CurrencyRates;

  factory CurrencyRates.fromJson(Map<String, dynamic> json) =>
      _$CurrencyRatesFromJson(json);

  double convertRate(
    SupportedCurrency currency,
    double amount, {
    bool reverse = false,
  }) {
    if (reverse) {
      return amount / currency.rate;
    }
    return amount * currency.rate;
  }

  double getRate(String currency) {
    var rate = rates[currency];
    if (rate != null) return rate.rate;
    Utils.log("Currency not found");
    return 0;
  }
}

// class CurrencyRates {
//   CurrencyRates({
//     this.usd = 0,
//     this.usdParallel = 0,
//     this.btc = 0,
//     this.eur = 0,
//     this.cny = 0,
//     this.rub = 0,
//     this.allValues = const {},
//     this.lastUpdateTime,
//     this.nextUpdateTime,
//   });

//   double usd;
//   double eur;
//   double cny;
//   // double try_;
//   double rub;

//   double usdParallel;
//   double btc;

//   Map<String, SupportedCurrency> allValues = {};

//   int? lastUpdateTime;
//   int? nextUpdateTime;

//   Map<String, double> get allRates => {
//     "USD_PARALLEL": usdParallel,
//     "BTC": btc,
//     "USD": usd,
//     "EUR": eur,
//     "CNY": cny,
//     "RUB": rub,
//   };

//   double convertRate(
//     SupportedCurrency currency,
//     double amount, {
//     bool reverse = false,
//   }) {
//     if (reverse) {
//       return amount / currency.rate;
//     }
//     return amount * currency.rate;
//   }

//   double getRate(String currency) {
//     var rate = allValues[currency];
//     if (rate != null) return rate.rate;
//     Utils.log("Currency not found");
//     return 0;
//   }

//   CurrencyRates copyWith({
//     double? usd,
//     double? usdParallel,
//     double? btc,
//     double? eur,
//     double? cny,
//     double? rub,
//   }) {
//     return CurrencyRates(
//       usd: usd ?? this.usd,
//       usdParallel: usdParallel ?? this.usdParallel,
//       btc: btc ?? this.btc,
//       eur: eur ?? this.eur,
//       cny: cny ?? this.cny,
//       rub: rub ?? this.rub,
//     );
//   }

//   @override
//   operator ==(Object other) =>
//       identical(this, other) ||
//       other is CurrencyRates &&
//           runtimeType == other.runtimeType &&
//           usd == other.usd &&
//           usdParallel == other.usdParallel &&
//           btc == other.btc &&
//           eur == other.eur &&
//           cny == other.cny &&
//           rub == other.rub &&
//           allValues == other.allValues &&
//           lastUpdateTime == other.lastUpdateTime &&
//           nextUpdateTime == other.nextUpdateTime;
//   @override
//   int get hashCode =>
//       Object.hash(usd, usdParallel, btc, eur, cny, rub);

//   CurrencyRates.fromJson(Map<String, dynamic> json)
//     : usd = json["USD"] ?? 0,
//       eur = json["EUR"] ?? 0,
//       cny = json["CNY"] ?? 0,
//       rub = json["RUB"] ?? 0,
//       usdParallel = json["USD_PARALLEL"] ?? 0,
//       btc = json["BTC"] ?? 0,
//       allValues = json["allValues"] != null
//           ? json["allValues"].map(
//               (key, value) => MapEntry(
//                 key,
//                 SupportedCurrency.fromJson(value),
//               ),
//             )
//           : {},
//       lastUpdateTime = json["time_last_update"] != null
//           ? int.parse(json["time_last_update"])
//           : null,
//       nextUpdateTime = json["time_next_update"] != null
//           ? int.parse(json["time_next_update"])
//           : null;

//   Map<String, dynamic> toJson() {
//     return {
//       ...allRates,
//       "allValues": allValues.map(
//         (key, value) => MapEntry(key, value.toJson()),
//       ),
//       "time_last_update": lastUpdateTime,
//       "time_next_update": nextUpdateTime,
//     };
//   }
// }
