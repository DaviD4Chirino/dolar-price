import 'package:doya/modules/home/pages/home_page.dart';
import 'package:doya/modules/settings/pages/settings_page.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static final String home = "/home";
  static final String settings = "/settings";
  static final String initial = home;

  static final Map<String, Widget Function(BuildContext)>
  routes = {
    home: (context) => const HomePage(),
    settings: (context) => const SettingsPage(),
  };
}
