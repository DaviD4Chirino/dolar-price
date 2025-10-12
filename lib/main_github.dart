import 'package:doya/main_app.dart';
import 'package:doya/main_shared.dart';
import 'package:doya/tokens/app/app_flavors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  AppFlavor.setFlavor(AppFlavors.github);

  if (kDebugMode) {
    print('Running on Github');
  }

  await MainShared.initializations();

  runApp(const ProviderScope(child: MainApp()));
}
