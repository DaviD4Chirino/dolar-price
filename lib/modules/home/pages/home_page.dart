import 'dart:convert';
import 'dart:io';

import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:awesome_dolar_price/tokens/app/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dolarPrice = useState<String>("0bs");
    final isLoading = useState(false);
    final t = AppLocalizations.of(context);

    Future fetchDolarPrice() async {
      if (isLoading.value) return;

      isLoading.value = true;
      double remoteValue = await getDolarPrice(context);
      dolarPrice.value = remoteValue.toStringAsFixed(3);
      isLoading.value = false;
    }

    useEffect(
      () {
        fetchDolarPrice();
        return null;
      },
      const [],
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
        onPressed: fetchDolarPrice,
        child: const Icon(Icons.replay_rounded),
      ),
      body: Center(
        child: isLoading.value
            ? CircularProgressIndicator()
            : Text("Dolar Price: ${dolarPrice.value}bs"),
      ),
    );
  }
}

Future<double> getDolarPrice(BuildContext context) async {
  try {
    final response = await http.get(
      // I had no idea this api existed, i was planning on scrapping https://www.bcv.org.ve
      Uri.parse("https://open.er-api.com/v6/latest/USD"),
    );
    final json = jsonDecode(response.body);
    return json['rates']['VES'];
  } on SocketException catch (e) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.message.toString(),
        ),
        duration: Duration(seconds: 5),
      ),
    );
    return 0;
  }
}
