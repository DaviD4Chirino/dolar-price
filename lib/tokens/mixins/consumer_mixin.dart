import 'package:doya/providers/theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

mixin ConsumerMixin {
  bool isLightMode(WidgetRef ref) {
    return ref.watch(themeModeProvider) == ThemeMode.light;
  }
}
