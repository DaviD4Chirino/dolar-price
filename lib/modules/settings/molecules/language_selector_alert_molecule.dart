import 'package:doya/l10n/app_localizations.dart';
import 'package:doya/providers/translation.dart';
import 'package:doya/tokens/utils/atoms/locale_code_atom.dart';
import 'package:doya/tokens/utils/atoms/localized.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageSelectorAlertMolecule extends HookConsumerWidget {
  const LanguageSelectorAlertMolecule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translationNotifier = ref.read(
      translationNotifierProvider.notifier,
    );
    final currentLocale = ref.watch(translationNotifierProvider);

    return SimpleDialog(
      title: Text(
        AppLocalizations.of(context).languageSelectorTitle,
      ),
      children: AppLocalizations.supportedLocales.map((locale) {
        void onTap() {
          translationNotifier.translate(locale.toLanguageTag());
          Navigator.of(context).pop();
        }

        return ListTile(
          selected: locale == currentLocale,
          leading: LocaleCodeAtom(locale.toLanguageTag()),
          title: Localized(
            locale: locale,
            builder: (context) =>
                Text(AppLocalizations.of(context).languageTitle),
          ),
          onTap: onTap,
        );
      }).toList(),

      /* content: ListView.builder(
        itemCount: AppLocalizations.supportedLocales.length,
        itemBuilder: (context, index) {
          final currentLocale =
              AppLocalizations.supportedLocales[index];

          void onTap() {
            translationNotifier
                .translate(currentLocale.toLanguageTag());
            Navigator.of(context).pop();
          }

          return ListTile(
            selected: currentLocale == locale,
            leading:
                LocaleCodeAtom(currentLocale.toLanguageTag()),
            title: Localized(
              locale: currentLocale,
              builder: (context) => Text(
                AppLocalizations.of(context).languageTitle,
              ),
            ),
            onTap: onTap,
          );
        },
      ), */
    );
  }

  Localizations title(
    BuildContext context,
    Locale currentLocale,
  ) {
    return Localizations.override(
      context: context,
      locale: currentLocale,
      child: Builder(
        builder: (context) {
          return Text(
            AppLocalizations.of(context).languageTitle,
          );
        },
      ),
    );
  }
}
