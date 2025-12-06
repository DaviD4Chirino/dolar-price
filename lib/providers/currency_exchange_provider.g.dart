// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_exchange_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrencyExchangeNotifier)
const currencyExchangeProvider = CurrencyExchangeNotifierProvider._();

final class CurrencyExchangeNotifierProvider
    extends $NotifierProvider<CurrencyExchangeNotifier, Quotes> {
  const CurrencyExchangeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currencyExchangeProvider',
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
    r'f0168d5301eff25be1d5005015381f5196572695';

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
