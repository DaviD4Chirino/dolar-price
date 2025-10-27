// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TranslationNotifier)
const translationProvider = TranslationNotifierProvider._();

final class TranslationNotifierProvider
    extends $NotifierProvider<TranslationNotifier, Locale> {
  const TranslationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'translationProvider',
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
    r'0fe638c7ae0cbeb6dd27f683fca7fd5f8f6aa012';

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
