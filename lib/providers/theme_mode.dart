import 'package:awesome_dolar_price/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    if (LocalStorage.getBool("theme-mode") == null) {
      return SchedulerBinding
                  .instance.platformDispatcher.platformBrightness ==
              Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
    } else {
      return LocalStorage.getBool("theme-mode")!
          ? ThemeMode.light
          : ThemeMode.dark;
    }
  }

  void setThemeMode(bool lightMode) {
    if (lightMode) {
      setLight();
      return;
    }
    setDark();
  }

  void setDark() {
    state = ThemeMode.dark;
    _setStatusBarColor();
    LocalStorage.setBool("theme-mode", false);
  }

  void setLight() {
    state = ThemeMode.light;
    _setStatusBarColor();
    LocalStorage.setBool("theme-mode", true);
  }

  void _setStatusBarColor() {
    SystemUiOverlayStyle brightness =
        state == ThemeMode.light || state == ThemeMode.system
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light;

    SystemChrome.setSystemUIOverlayStyle(brightness);
  }
}
