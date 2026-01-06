// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quotes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Quotes {

 int get lastUpdateTime; int get nextUpdateTime; CurrencyRates get rates; Quotes? get lastQuote;
/// Create a copy of Quotes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuotesCopyWith<Quotes> get copyWith => _$QuotesCopyWithImpl<Quotes>(this as Quotes, _$identity);

  /// Serializes this Quotes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Quotes&&(identical(other.lastUpdateTime, lastUpdateTime) || other.lastUpdateTime == lastUpdateTime)&&(identical(other.nextUpdateTime, nextUpdateTime) || other.nextUpdateTime == nextUpdateTime)&&(identical(other.rates, rates) || other.rates == rates)&&(identical(other.lastQuote, lastQuote) || other.lastQuote == lastQuote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastUpdateTime,nextUpdateTime,rates,lastQuote);

@override
String toString() {
  return 'Quotes(lastUpdateTime: $lastUpdateTime, nextUpdateTime: $nextUpdateTime, rates: $rates, lastQuote: $lastQuote)';
}


}

/// @nodoc
abstract mixin class $QuotesCopyWith<$Res>  {
  factory $QuotesCopyWith(Quotes value, $Res Function(Quotes) _then) = _$QuotesCopyWithImpl;
@useResult
$Res call({
 int lastUpdateTime, int nextUpdateTime, CurrencyRates rates, Quotes? lastQuote
});


$CurrencyRatesCopyWith<$Res> get rates;$QuotesCopyWith<$Res>? get lastQuote;

}
/// @nodoc
class _$QuotesCopyWithImpl<$Res>
    implements $QuotesCopyWith<$Res> {
  _$QuotesCopyWithImpl(this._self, this._then);

  final Quotes _self;
  final $Res Function(Quotes) _then;

/// Create a copy of Quotes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastUpdateTime = null,Object? nextUpdateTime = null,Object? rates = null,Object? lastQuote = freezed,}) {
  return _then(_self.copyWith(
lastUpdateTime: null == lastUpdateTime ? _self.lastUpdateTime : lastUpdateTime // ignore: cast_nullable_to_non_nullable
as int,nextUpdateTime: null == nextUpdateTime ? _self.nextUpdateTime : nextUpdateTime // ignore: cast_nullable_to_non_nullable
as int,rates: null == rates ? _self.rates : rates // ignore: cast_nullable_to_non_nullable
as CurrencyRates,lastQuote: freezed == lastQuote ? _self.lastQuote : lastQuote // ignore: cast_nullable_to_non_nullable
as Quotes?,
  ));
}
/// Create a copy of Quotes
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyRatesCopyWith<$Res> get rates {
  
  return $CurrencyRatesCopyWith<$Res>(_self.rates, (value) {
    return _then(_self.copyWith(rates: value));
  });
}/// Create a copy of Quotes
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuotesCopyWith<$Res>? get lastQuote {
    if (_self.lastQuote == null) {
    return null;
  }

  return $QuotesCopyWith<$Res>(_self.lastQuote!, (value) {
    return _then(_self.copyWith(lastQuote: value));
  });
}
}


/// Adds pattern-matching-related methods to [Quotes].
extension QuotesPatterns on Quotes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Quotes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Quotes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Quotes value)  $default,){
final _that = this;
switch (_that) {
case _Quotes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Quotes value)?  $default,){
final _that = this;
switch (_that) {
case _Quotes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int lastUpdateTime,  int nextUpdateTime,  CurrencyRates rates,  Quotes? lastQuote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Quotes() when $default != null:
return $default(_that.lastUpdateTime,_that.nextUpdateTime,_that.rates,_that.lastQuote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int lastUpdateTime,  int nextUpdateTime,  CurrencyRates rates,  Quotes? lastQuote)  $default,) {final _that = this;
switch (_that) {
case _Quotes():
return $default(_that.lastUpdateTime,_that.nextUpdateTime,_that.rates,_that.lastQuote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int lastUpdateTime,  int nextUpdateTime,  CurrencyRates rates,  Quotes? lastQuote)?  $default,) {final _that = this;
switch (_that) {
case _Quotes() when $default != null:
return $default(_that.lastUpdateTime,_that.nextUpdateTime,_that.rates,_that.lastQuote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Quotes extends Quotes {
  const _Quotes({required this.lastUpdateTime, required this.nextUpdateTime, required this.rates, this.lastQuote}): super._();
  factory _Quotes.fromJson(Map<String, dynamic> json) => _$QuotesFromJson(json);

@override final  int lastUpdateTime;
@override final  int nextUpdateTime;
@override final  CurrencyRates rates;
@override final  Quotes? lastQuote;

/// Create a copy of Quotes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuotesCopyWith<_Quotes> get copyWith => __$QuotesCopyWithImpl<_Quotes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuotesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Quotes&&(identical(other.lastUpdateTime, lastUpdateTime) || other.lastUpdateTime == lastUpdateTime)&&(identical(other.nextUpdateTime, nextUpdateTime) || other.nextUpdateTime == nextUpdateTime)&&(identical(other.rates, rates) || other.rates == rates)&&(identical(other.lastQuote, lastQuote) || other.lastQuote == lastQuote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastUpdateTime,nextUpdateTime,rates,lastQuote);

@override
String toString() {
  return 'Quotes(lastUpdateTime: $lastUpdateTime, nextUpdateTime: $nextUpdateTime, rates: $rates, lastQuote: $lastQuote)';
}


}

/// @nodoc
abstract mixin class _$QuotesCopyWith<$Res> implements $QuotesCopyWith<$Res> {
  factory _$QuotesCopyWith(_Quotes value, $Res Function(_Quotes) _then) = __$QuotesCopyWithImpl;
@override @useResult
$Res call({
 int lastUpdateTime, int nextUpdateTime, CurrencyRates rates, Quotes? lastQuote
});


@override $CurrencyRatesCopyWith<$Res> get rates;@override $QuotesCopyWith<$Res>? get lastQuote;

}
/// @nodoc
class __$QuotesCopyWithImpl<$Res>
    implements _$QuotesCopyWith<$Res> {
  __$QuotesCopyWithImpl(this._self, this._then);

  final _Quotes _self;
  final $Res Function(_Quotes) _then;

/// Create a copy of Quotes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastUpdateTime = null,Object? nextUpdateTime = null,Object? rates = null,Object? lastQuote = freezed,}) {
  return _then(_Quotes(
lastUpdateTime: null == lastUpdateTime ? _self.lastUpdateTime : lastUpdateTime // ignore: cast_nullable_to_non_nullable
as int,nextUpdateTime: null == nextUpdateTime ? _self.nextUpdateTime : nextUpdateTime // ignore: cast_nullable_to_non_nullable
as int,rates: null == rates ? _self.rates : rates // ignore: cast_nullable_to_non_nullable
as CurrencyRates,lastQuote: freezed == lastQuote ? _self.lastQuote : lastQuote // ignore: cast_nullable_to_non_nullable
as Quotes?,
  ));
}

/// Create a copy of Quotes
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyRatesCopyWith<$Res> get rates {
  
  return $CurrencyRatesCopyWith<$Res>(_self.rates, (value) {
    return _then(_self.copyWith(rates: value));
  });
}/// Create a copy of Quotes
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuotesCopyWith<$Res>? get lastQuote {
    if (_self.lastQuote == null) {
    return null;
  }

  return $QuotesCopyWith<$Res>(_self.lastQuote!, (value) {
    return _then(_self.copyWith(lastQuote: value));
  });
}
}

// dart format on
