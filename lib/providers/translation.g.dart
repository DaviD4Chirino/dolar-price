// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(TranslationNotifier)
const translationNotifierProvider = TranslationNotifierProvider._();

final class TranslationNotifierProvider
    extends $NotifierProvider<TranslationNotifier, Locale> {
  const TranslationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'translationNotifierProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$translationNotifierHash();

  @$internal
  @override
  TranslationNotifier create() => TranslationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$translationNotifierHash() =>
    r'4c873a0de7aa6a71d195138c1f8fac64499cc8af';

abstract class _$TranslationNotifier extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
