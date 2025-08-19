// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_exchange_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(CurrencyExchangeNotifier)
const currencyExchangeNotifierProvider = CurrencyExchangeNotifierProvider._();

final class CurrencyExchangeNotifierProvider
    extends $NotifierProvider<CurrencyExchangeNotifier, CurrencyExchange> {
  const CurrencyExchangeNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'currencyExchangeNotifierProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$currencyExchangeNotifierHash();

  @$internal
  @override
  CurrencyExchangeNotifier create() => CurrencyExchangeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrencyExchange value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrencyExchange>(value),
    );
  }
}

String _$currencyExchangeNotifierHash() =>
    r'98e41450811aa01df9ada55135825feb2761c3f7';

abstract class _$CurrencyExchangeNotifier extends $Notifier<CurrencyExchange> {
  CurrencyExchange build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CurrencyExchange, CurrencyExchange>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<CurrencyExchange, CurrencyExchange>,
        CurrencyExchange,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
