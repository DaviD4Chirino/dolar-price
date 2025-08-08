import 'package:flutter/material.dart';

/// A widget that overrides the current locale with the given locale.
/// Use the provided [Context] to access the current locale.
class Localized extends StatelessWidget {
  const Localized({
    required this.locale,
    required this.builder,
    this.delegates,
    super.key,
  });

  final Widget Function(BuildContext context) builder;
  final Locale locale;
  final List<LocalizationsDelegate<dynamic>>? delegates;

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      delegates: delegates,
      locale: locale,
      child: Builder(builder: builder),
    );
  }

  /// A helper method to create a [Localized] widget with a given locale code.
  static withCode({
    required String code,
    required Widget Function(BuildContext context) builder,
  }) {
    return Localized(
      locale: Locale(code),
      builder: builder,
    );
  }
}
