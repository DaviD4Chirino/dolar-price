import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:awesome_dolar_price/modules/settings/molecules/language_selector_alert_molecule.dart';
import 'package:awesome_dolar_price/providers/translation.dart';
import 'package:awesome_dolar_price/tokens/utils/atoms/locale_code_atom.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageSwitcherAtom extends HookConsumerWidget {
  const LanguageSwitcherAtom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Locale currentLocale =
        ref.watch(translationNotifierProvider);

    var t = AppLocalizations.of(context);
    return ListTile(
      title: Text(t.languageSwitcherTitle),
      leading: const Icon(Icons.translate),
      trailing: LocaleCodeAtom(currentLocale.toLanguageTag()),
      subtitle: Text(t.languageSwitcherSubtitle),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) =>
              const LanguageSelectorAlertMolecule(),
        );
      },
    );
  }
}
