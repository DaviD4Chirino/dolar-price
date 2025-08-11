import 'dart:convert';
import 'dart:io';

import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:awesome_dolar_price/tokens/app/app_routes.dart';
import 'package:awesome_dolar_price/tokens/app/app_sizing.dart';
import 'package:awesome_dolar_price/tokens/app/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dolarPrice = useState<String>("0");
    final isLoading = useState(false);
    final t = AppLocalizations.of(context);
    final ThemeData theme = Theme.of(context);

    Future fetchDolarPrice() async {
      if (isLoading.value) return;

      try {
        isLoading.value = true;
        double remoteValue = await getDolarPrice(context);
        dolarPrice.value = remoteValue.toStringAsFixed(3);
        isLoading.value = false;
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
      }
      isLoading.value = false;

      /* isLoading.value = true;
      double remoteValue = await getDolarPrice(context);
      dolarPrice.value = remoteValue.toStringAsFixed(3);
      isLoading.value = false; */
    }

    useEffect(
      () {
        fetchDolarPrice();
        return null;
      },
      const [],
    );

    return Scaffold(
      appBar: appBar(t, context),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchDolarPrice,
        child: const Icon(Icons.replay_rounded),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.sm),
          child: Column(
            spacing: AppSpacing.lg,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            // columnSizes: [1.fr],
            // rowSizes: [0.3.fr, 50.px, 1.fr],
            children: [
              SizedBox(
                height: AppSizing.sm,
              ),
              Image.asset(
                "assets/icons/logo/logo-dark.png",
                width: 100,
                height: 100,
              ),
              if (isLoading.value)
                LinearProgressIndicator()
              else
                Container(
                  decoration: BoxDecoration(
                    color: theme
                        .colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    "${dolarPrice.value}Bs",
                    style: theme.textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              CurrencyDisplayMolecule(
                currency: "\$ (CAD)",
                value: "123.00",
              ),
              CurrencyDisplayMolecule(
                currency: "EURO",
                value: "123.00",
              ),
              CurrencyDisplayMolecule(
                currency: "YEN",
                value: "123.00",
              ),
              CurrencyDisplayMolecule(
                currency: "PESO",
                value: "123.00",
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar(AppLocalizations t, BuildContext context) {
    return AppBar(
      title: Text(t.homeTitle),
      actions: [
        IconButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.settings),
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }
}

Future<double> getDolarPrice(BuildContext context) async {
  final response = await http.get(
    // I had no idea this api existed, i was planning on scrapping https://www.bcv.org.ve
    Uri.parse("https://open.er-api.com/v6/latest/USD"),
  );
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return json['rates']['VES'];
  }
  throw SocketException("Could not get dolar price");
}

class CurrencyDisplayMolecule extends StatelessWidget {
  const CurrencyDisplayMolecule({
    super.key,
    required this.currency,
    required this.value,
  });

  final String currency;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          currency,
          style: theme.textTheme.bodyLarge,
        ),
        Text(value, style: theme.textTheme.bodyLarge),
      ],
    );
  }
}
