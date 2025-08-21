// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_currency_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// Use this to change the main currency,
/// Use [Currencies] to compare the currency
@ProviderFor(MainCurrencyNotifier)
const mainCurrencyNotifierProvider = MainCurrencyNotifierProvider._();

/// Use this to change the main currency,
/// Use [Currencies] to compare the currency
final class MainCurrencyNotifierProvider
    extends $NotifierProvider<MainCurrencyNotifier, String> {
  /// Use this to change the main currency,
  /// Use [Currencies] to compare the currency
  const MainCurrencyNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mainCurrencyNotifierProvider',
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
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$mainCurrencyNotifierHash() =>
    r'07ff3d56cda53bd17b62bdc4ff2dbf7c1115e044';

abstract class _$MainCurrencyNotifier extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
