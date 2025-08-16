// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dolar_price.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(DolarPriceNotifier)
const dolarPriceNotifierProvider = DolarPriceNotifierProvider._();

final class DolarPriceNotifierProvider
    extends $NotifierProvider<DolarPriceNotifier, CurrencyExchange> {
  const DolarPriceNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'dolarPriceNotifierProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dolarPriceNotifierHash();

  @$internal
  @override
  DolarPriceNotifier create() => DolarPriceNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrencyExchange value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrencyExchange>(value),
    );
  }
}

String _$dolarPriceNotifierHash() =>
    r'a2be415278963a88f0d4e3c0abe1dd2ba9dfb032';

abstract class _$DolarPriceNotifier extends $Notifier<CurrencyExchange> {
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
