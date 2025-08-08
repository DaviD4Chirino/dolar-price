import 'package:awesome_flutter_template/main_app.dart';
import 'package:awesome_flutter_template/tokens/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializations();
  runApp(const ProviderScope(child: MainApp()));
}

Future<List<void>> initializations() async {
  return Future.wait([
    LocalStorage.init(),
  ]);
}
