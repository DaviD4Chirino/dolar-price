// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supported_currency.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SupportedCurrency {

 String get code; String get name; String? get symbol;
/// Create a copy of SupportedCurrency
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedCurrencyCopyWith<SupportedCurrency> get copyWith => _$SupportedCurrencyCopyWithImpl<SupportedCurrency>(this as SupportedCurrency, _$identity);

  /// Serializes this SupportedCurrency to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedCurrency&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,symbol);

@override
String toString() {
  return 'SupportedCurrency(code: $code, name: $name, symbol: $symbol)';
}


}

/// @nodoc
abstract mixin class $SupportedCurrencyCopyWith<$Res>  {
  factory $SupportedCurrencyCopyWith(SupportedCurrency value, $Res Function(SupportedCurrency) _then) = _$SupportedCurrencyCopyWithImpl;
@useResult
$Res call({
 String code, String name, String? symbol
});




}
/// @nodoc
class _$SupportedCurrencyCopyWithImpl<$Res>
    implements $SupportedCurrencyCopyWith<$Res> {
  _$SupportedCurrencyCopyWithImpl(this._self, this._then);

  final SupportedCurrency _self;
  final $Res Function(SupportedCurrency) _then;

/// Create a copy of SupportedCurrency
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? symbol = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SupportedCurrency].
extension SupportedCurrencyPatterns on SupportedCurrency {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportedCurrency value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportedCurrency() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportedCurrency value)  $default,){
final _that = this;
switch (_that) {
case _SupportedCurrency():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportedCurrency value)?  $default,){
final _that = this;
switch (_that) {
case _SupportedCurrency() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  String? symbol)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportedCurrency() when $default != null:
return $default(_that.code,_that.name,_that.symbol);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  String? symbol)  $default,) {final _that = this;
switch (_that) {
case _SupportedCurrency():
return $default(_that.code,_that.name,_that.symbol);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  String? symbol)?  $default,) {final _that = this;
switch (_that) {
case _SupportedCurrency() when $default != null:
return $default(_that.code,_that.name,_that.symbol);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupportedCurrency extends SupportedCurrency {
  const _SupportedCurrency({required this.code, required this.name, this.symbol}): super._();
  factory _SupportedCurrency.fromJson(Map<String, dynamic> json) => _$SupportedCurrencyFromJson(json);

@override final  String code;
@override final  String name;
@override final  String? symbol;

/// Create a copy of SupportedCurrency
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportedCurrencyCopyWith<_SupportedCurrency> get copyWith => __$SupportedCurrencyCopyWithImpl<_SupportedCurrency>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedCurrencyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportedCurrency&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,symbol);

@override
String toString() {
  return 'SupportedCurrency(code: $code, name: $name, symbol: $symbol)';
}


}

/// @nodoc
abstract mixin class _$SupportedCurrencyCopyWith<$Res> implements $SupportedCurrencyCopyWith<$Res> {
  factory _$SupportedCurrencyCopyWith(_SupportedCurrency value, $Res Function(_SupportedCurrency) _then) = __$SupportedCurrencyCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String? symbol
});




}
/// @nodoc
class __$SupportedCurrencyCopyWithImpl<$Res>
    implements _$SupportedCurrencyCopyWith<$Res> {
  __$SupportedCurrencyCopyWithImpl(this._self, this._then);

  final _SupportedCurrency _self;
  final $Res Function(_SupportedCurrency) _then;

/// Create a copy of SupportedCurrency
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? symbol = freezed,}) {
  return _then(_SupportedCurrency(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
