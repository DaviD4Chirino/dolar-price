// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency_rates.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurrencyRates {

 Map<String, SupportedCurrency> get rates; int? get lastUpdateTime; int? get nextUpdateTime;
/// Create a copy of CurrencyRates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyRatesCopyWith<CurrencyRates> get copyWith => _$CurrencyRatesCopyWithImpl<CurrencyRates>(this as CurrencyRates, _$identity);

  /// Serializes this CurrencyRates to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyRates&&const DeepCollectionEquality().equals(other.rates, rates)&&(identical(other.lastUpdateTime, lastUpdateTime) || other.lastUpdateTime == lastUpdateTime)&&(identical(other.nextUpdateTime, nextUpdateTime) || other.nextUpdateTime == nextUpdateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(rates),lastUpdateTime,nextUpdateTime);

@override
String toString() {
  return 'CurrencyRates(rates: $rates, lastUpdateTime: $lastUpdateTime, nextUpdateTime: $nextUpdateTime)';
}


}

/// @nodoc
abstract mixin class $CurrencyRatesCopyWith<$Res>  {
  factory $CurrencyRatesCopyWith(CurrencyRates value, $Res Function(CurrencyRates) _then) = _$CurrencyRatesCopyWithImpl;
@useResult
$Res call({
 Map<String, SupportedCurrency> rates, int? lastUpdateTime, int? nextUpdateTime
});




}
/// @nodoc
class _$CurrencyRatesCopyWithImpl<$Res>
    implements $CurrencyRatesCopyWith<$Res> {
  _$CurrencyRatesCopyWithImpl(this._self, this._then);

  final CurrencyRates _self;
  final $Res Function(CurrencyRates) _then;

/// Create a copy of CurrencyRates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rates = null,Object? lastUpdateTime = freezed,Object? nextUpdateTime = freezed,}) {
  return _then(_self.copyWith(
rates: null == rates ? _self.rates : rates // ignore: cast_nullable_to_non_nullable
as Map<String, SupportedCurrency>,lastUpdateTime: freezed == lastUpdateTime ? _self.lastUpdateTime : lastUpdateTime // ignore: cast_nullable_to_non_nullable
as int?,nextUpdateTime: freezed == nextUpdateTime ? _self.nextUpdateTime : nextUpdateTime // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrencyRates].
extension CurrencyRatesPatterns on CurrencyRates {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrencyRates value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrencyRates() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrencyRates value)  $default,){
final _that = this;
switch (_that) {
case _CurrencyRates():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrencyRates value)?  $default,){
final _that = this;
switch (_that) {
case _CurrencyRates() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, SupportedCurrency> rates,  int? lastUpdateTime,  int? nextUpdateTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrencyRates() when $default != null:
return $default(_that.rates,_that.lastUpdateTime,_that.nextUpdateTime);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, SupportedCurrency> rates,  int? lastUpdateTime,  int? nextUpdateTime)  $default,) {final _that = this;
switch (_that) {
case _CurrencyRates():
return $default(_that.rates,_that.lastUpdateTime,_that.nextUpdateTime);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, SupportedCurrency> rates,  int? lastUpdateTime,  int? nextUpdateTime)?  $default,) {final _that = this;
switch (_that) {
case _CurrencyRates() when $default != null:
return $default(_that.rates,_that.lastUpdateTime,_that.nextUpdateTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrencyRates extends CurrencyRates {
  const _CurrencyRates({required final  Map<String, SupportedCurrency> rates, this.lastUpdateTime, this.nextUpdateTime}): _rates = rates,super._();
  factory _CurrencyRates.fromJson(Map<String, dynamic> json) => _$CurrencyRatesFromJson(json);

 final  Map<String, SupportedCurrency> _rates;
@override Map<String, SupportedCurrency> get rates {
  if (_rates is EqualUnmodifiableMapView) return _rates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rates);
}

@override final  int? lastUpdateTime;
@override final  int? nextUpdateTime;

/// Create a copy of CurrencyRates
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrencyRatesCopyWith<_CurrencyRates> get copyWith => __$CurrencyRatesCopyWithImpl<_CurrencyRates>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrencyRatesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrencyRates&&const DeepCollectionEquality().equals(other._rates, _rates)&&(identical(other.lastUpdateTime, lastUpdateTime) || other.lastUpdateTime == lastUpdateTime)&&(identical(other.nextUpdateTime, nextUpdateTime) || other.nextUpdateTime == nextUpdateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rates),lastUpdateTime,nextUpdateTime);

@override
String toString() {
  return 'CurrencyRates(rates: $rates, lastUpdateTime: $lastUpdateTime, nextUpdateTime: $nextUpdateTime)';
}


}

/// @nodoc
abstract mixin class _$CurrencyRatesCopyWith<$Res> implements $CurrencyRatesCopyWith<$Res> {
  factory _$CurrencyRatesCopyWith(_CurrencyRates value, $Res Function(_CurrencyRates) _then) = __$CurrencyRatesCopyWithImpl;
@override @useResult
$Res call({
 Map<String, SupportedCurrency> rates, int? lastUpdateTime, int? nextUpdateTime
});




}
/// @nodoc
class __$CurrencyRatesCopyWithImpl<$Res>
    implements _$CurrencyRatesCopyWith<$Res> {
  __$CurrencyRatesCopyWithImpl(this._self, this._then);

  final _CurrencyRates _self;
  final $Res Function(_CurrencyRates) _then;

/// Create a copy of CurrencyRates
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rates = null,Object? lastUpdateTime = freezed,Object? nextUpdateTime = freezed,}) {
  return _then(_CurrencyRates(
rates: null == rates ? _self._rates : rates // ignore: cast_nullable_to_non_nullable
as Map<String, SupportedCurrency>,lastUpdateTime: freezed == lastUpdateTime ? _self.lastUpdateTime : lastUpdateTime // ignore: cast_nullable_to_non_nullable
as int?,nextUpdateTime: freezed == nextUpdateTime ? _self.nextUpdateTime : nextUpdateTime // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
