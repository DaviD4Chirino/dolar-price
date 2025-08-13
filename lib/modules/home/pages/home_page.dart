import 'dart:io';

import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:awesome_dolar_price/modules/home/molecule/currency_display_molecule.dart';
import 'package:awesome_dolar_price/providers/dolar_price.dart';
import 'package:awesome_dolar_price/tokens/app/app_routes.dart';
import 'package:awesome_dolar_price/tokens/app/app_sizing.dart';
import 'package:awesome_dolar_price/tokens/app/app_spacing.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final t = AppLocalizations.of(context);

    final dolarPriceNotifier = ref.read(dolarPriceNotifierProvider.notifier);

    final dolarPriceProvider = ref.watch(dolarPriceNotifierProvider);
    final dolarPrice = dolarPriceProvider.rates.usd;
    var entries = dolarPriceProvider.rates.currencies.entries.map(
      (e) => CurrencyDisplayMolecule(
        currency: e.key,
        value: e.value > 0.0
            ? e.value.toStringAsFixed(3)
            : e.value.toStringAsFixed(0),
      ),
    );

    Future fetchDolarPrice() async {
      if (isLoading.value) return;

      try {
        isLoading.value = true;
        await dolarPriceNotifier.fetchPrices();
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
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            spacing: AppSpacing.lg,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            // columnSizes: [1.fr],
            // rowSizes: [0.3.fr, 50.px, 1.fr],
            children: [
              SizedBox(
                height: AppSizing.lg,
              ),
              Image.asset(
                "assets/icons/logo/logo-dark.png",
                width: 100,
                height: 100,
              ),
              if (isLoading.value)
                LinearProgressIndicator()
              else
                dolarPriceDisplay(context, dolarPrice: dolarPrice),
              ...entries
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
          onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }

  Widget dolarPriceDisplay(BuildContext context, {required double dolarPrice}) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.all(
          Radius.circular(AppSpacing.lg),
        ),
      ),
      // height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Text(
          "${dolarPrice.toStringAsFixed(3)} Bs",
          style: theme.textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
