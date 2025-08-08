import 'dart:convert';

import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:awesome_dolar_price/tokens/app/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    final dolarPrice = useState<String>("Loading...");
    AppLocalizations t = AppLocalizations.of(context);

    useEffect(
      () {
        getDolarPrice().then((value) {
          dolarPrice.value = "${value.toStringAsFixed(3)}bs";
        });
        return null;
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(t.homeTitle),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.settings),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.value++,
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: Text("Dolar Price: ${dolarPrice.value}")),
    );
  }
}

Future<double> getDolarPrice() async {
  try {
    final response = await http.get(
      Uri.parse("https://open.er-api.com/v6/latest/USD"),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['rates']['VES'];
    } else {
      throw Exception('Failed to load Dolar Price');
    }
  } on Exception catch (e) {
    print(e);
    rethrow;
  }
}
