import 'package:doya/l10n/app_localizations.dart';
import 'package:doya/providers/theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeModeSwitchAtom extends ConsumerWidget {
  const ThemeModeSwitchAtom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeProvider = ref.watch(
      themeModeNotifierProvider,
    );
    final themeModeNotifier = ref.read(
      themeModeNotifierProvider.notifier,
    );
    bool isLight = themeModeProvider == ThemeMode.light;

    var t = AppLocalizations.of(context);
    return ListTile(
      title: Text(t.themeModeTitle),
      subtitle: Text(
        isLight ? t.changeToDarkMode : t.changeToLightMode,
      ),
      leading: isLight
          ? Icon(Icons.dark_mode_outlined)
          : Icon(Icons.light_mode_outlined),
      onTap: () => themeModeNotifier.setThemeMode(!isLight),
      trailing: Switch(
        value: isLight,
        onChanged: (value) =>
            themeModeNotifier.setThemeMode(value),
      ),
    );
  }
}
