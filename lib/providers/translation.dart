import 'dart:io';

import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:awesome_dolar_price/tokens/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation.g.dart';

@Riverpod(keepAlive: true)
class TranslationNotifier extends _$TranslationNotifier {
  @override
  Locale build() {
    /// Get the language code from the device
    return AppLocalizations.supportedLocales.firstWhere(
      (element) =>
          element.toLanguageTag() == Platform.localeName,
      orElse: () => AppLocalizations.supportedLocales.first,
    );
  }

  void init() {
    String? savedCode = getLanguageCode();
    // Presumably, the build makes sure its not null
    if (savedCode == null) {
      state = AppLocalizations.supportedLocales.firstWhere(
        (element) => element.toLanguageTag() == 'en',
        orElse: () => AppLocalizations.supportedLocales.first,
      );
      return;
    }
    translate(savedCode);
  }

  void translate(String code) {
    final locale = AppLocalizations.supportedLocales.firstWhere(
      (element) => element.toLanguageTag() == code,
      orElse: () => AppLocalizations.supportedLocales.first,
    );
    saveLanguageCode(locale.languageCode);
    state = locale;
  }

  Future saveLanguageCode(String code) async {
    return LocalStorage.setString("language", code);
  }

  String? getLanguageCode() {
    return LocalStorage.getString("language");
  }
}
