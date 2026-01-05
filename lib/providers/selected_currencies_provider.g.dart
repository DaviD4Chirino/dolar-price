// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_currencies_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedCurrenciesNotifier)
const selectedCurrenciesProvider = SelectedCurrenciesNotifierProvider._();

final class SelectedCurrenciesNotifierProvider
    extends
        $NotifierProvider<SelectedCurrenciesNotifier, List<SupportedCurrency>> {
  const SelectedCurrenciesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCurrenciesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCurrenciesNotifierHash();

  @$internal
  @override
  SelectedCurrenciesNotifier create() => SelectedCurrenciesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<SupportedCurrency> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<SupportedCurrency>>(value),
    );
  }
}

String _$selectedCurrenciesNotifierHash() =>
    r'd873b1451e50dbcf543963ddf146a9c2db8e2ef6';

abstract class _$SelectedCurrenciesNotifier
    extends $Notifier<List<SupportedCurrency>> {
  List<SupportedCurrency> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<List<SupportedCurrency>, List<SupportedCurrency>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<SupportedCurrency>, List<SupportedCurrency>>,
              List<SupportedCurrency>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
