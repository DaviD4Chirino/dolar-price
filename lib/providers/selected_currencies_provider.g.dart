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
    extends $NotifierProvider<SelectedCurrenciesNotifier, List<String>> {
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
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$selectedCurrenciesNotifierHash() =>
    r'4b7a4bd1ee6652272241b000690303c41ef0f3d0';

abstract class _$SelectedCurrenciesNotifier extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
