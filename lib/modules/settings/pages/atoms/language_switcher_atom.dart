import 'package:doya/l10n/app_localizations.dart';
import 'package:doya/modules/settings/molecules/language_selector_alert_molecule.dart';
import 'package:doya/providers/translation.dart';
import 'package:doya/tokens/utils/atoms/locale_code_atom.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageSwitcherAtom extends HookConsumerWidget {
  const LanguageSwitcherAtom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Locale currentLocale = ref.watch(translationProvider);

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
