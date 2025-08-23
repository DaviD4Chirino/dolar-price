import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:awesome_dolar_price/providers/theme_mode.dart';
import 'package:awesome_dolar_price/providers/translation.dart';
import 'package:awesome_dolar_price/tokens/app/app_routes.dart';
import 'package:awesome_dolar_price/tokens/app/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  Locale get locale => ref.watch(translationNotifierProvider);
  TranslationNotifier get translationNotifier =>
      ref.read(translationNotifierProvider.notifier);
  ThemeMode get themeModeProvider =>
      ref.watch(themeModeNotifierProvider);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      if (!mounted) return;
      ref.read(translationNotifierProvider.notifier).init();

      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        localizationsDelegates:
            AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        title: "Awesome Dolar Price",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeModeProvider,
        initialRoute: AppRoutes.initial,
        routes: AppRoutes.routes,
      ),
    );
  }
}
