import 'package:awesome_dolar_price/extensions/double_extensions/sized_box_extension.dart';
import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:awesome_dolar_price/modules/settings/pages/atoms/language_switcher_atom.dart';
import 'package:awesome_dolar_price/modules/settings/pages/atoms/main_currency_selector.dart';
import 'package:awesome_dolar_price/modules/settings/pages/atoms/theme_mode_switch_atom.dart';
import 'package:awesome_dolar_price/tokens/app/app_sizing.dart';
import 'package:awesome_dolar_price/tokens/atoms/app_logo.dart';
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
          AppLogo(extended: true, height: 50),
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
