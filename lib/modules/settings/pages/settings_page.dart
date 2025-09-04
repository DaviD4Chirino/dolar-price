import 'package:doya/extensions/double_extensions/sized_box_extension.dart';
import 'package:doya/l10n/app_localizations.dart';
import 'package:doya/modules/settings/pages/atoms/language_switcher_atom.dart';
import 'package:doya/modules/settings/pages/atoms/main_currency_selector.dart';
import 'package:doya/modules/settings/pages/atoms/theme_mode_switch_atom.dart';
import 'package:doya/tokens/app/app_sizing.dart';
import 'package:doya/tokens/atoms/app_logo.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.settingsTitle)),
      body: ListView(
        children: [
          AppSizing.xxl.sizedBoxH,
          AppLogo(height: 80, type: LogoType.title),
          AppSizing.xl.sizedBoxH,
          Divider(),
          ThemeModeSwitchAtom(),
          LanguageSwitcherAtom(),
          MainCurrencySelector(),
        ],
      ),
    );
  }
}
