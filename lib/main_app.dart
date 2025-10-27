import 'package:doya/l10n/app_localizations.dart';
import 'package:doya/providers/theme_mode.dart';
import 'package:doya/providers/translation.dart';
import 'package:doya/tokens/app/app_routes.dart';
import 'package:doya/tokens/app/app_theme.dart';
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
  Locale get locale => ref.watch(translationProvider);
  TranslationNotifier get translationNotifier =>
      ref.read(translationProvider.notifier);
  ThemeMode get themeModeNotifierProvider =>
      ref.watch(themeModeProvider);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      if (!mounted) return;
      ref.read(translationProvider.notifier).init();

      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          physics: const ClampingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
        ),
        localizationsDelegates:
            AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        title: "Awesome Dolar Price",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeModeNotifierProvider,
        initialRoute: AppRoutes.initial,
        routes: AppRoutes.routes,
      ),
    );
  }
}
