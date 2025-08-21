// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_exchange_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(CurrencyExchangeNotifier)
const currencyExchangeNotifierProvider = CurrencyExchangeNotifierProvider._();

final class CurrencyExchangeNotifierProvider
    extends $NotifierProvider<CurrencyExchangeNotifier, Quotes> {
  const CurrencyExchangeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currencyExchangeNotifierProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currencyExchangeNotifierHash();

  @$internal
  @override
  CurrencyExchangeNotifier create() => CurrencyExchangeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Quotes value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Quotes>(value),
    );
  }
}

String _$currencyExchangeNotifierHash() =>
    r'f4de46add3abfe18c99ec53534ac58f525f0dfd4';

abstract class _$CurrencyExchangeNotifier extends $Notifier<Quotes> {
  Quotes build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Quotes, Quotes>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Quotes, Quotes>,
              Quotes,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
