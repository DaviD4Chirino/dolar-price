// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_currency_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Use this to change the main currency,
/// Use [Currencies] to compare the currency

@ProviderFor(MainCurrencyNotifier)
const mainCurrencyProvider = MainCurrencyNotifierProvider._();

/// Use this to change the main currency,
/// Use [Currencies] to compare the currency
final class MainCurrencyNotifierProvider
    extends $NotifierProvider<MainCurrencyNotifier, SupportedCurrency> {
  /// Use this to change the main currency,
  /// Use [Currencies] to compare the currency
  const MainCurrencyNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mainCurrencyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mainCurrencyNotifierHash();

  @$internal
  @override
  MainCurrencyNotifier create() => MainCurrencyNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupportedCurrency value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupportedCurrency>(value),
    );
  }
}

String _$mainCurrencyNotifierHash() =>
    r'd1761db6cc3219c35e7ee0717a69ebc22317b317';

/// Use this to change the main currency,
/// Use [Currencies] to compare the currency

abstract class _$MainCurrencyNotifier extends $Notifier<SupportedCurrency> {
  SupportedCurrency build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SupportedCurrency, SupportedCurrency>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SupportedCurrency, SupportedCurrency>,
              SupportedCurrency,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
