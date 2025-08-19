import 'package:awesome_dolar_price/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:awesome_dolar_price/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializations();
  runApp(const ProviderScope(child: MainApp()));
}

Future<List<void>> initializations() async {
  return Future.wait([
    LocalStorage.init(),
  ]);
}
