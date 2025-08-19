import 'dart:io';

import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:awesome_dolar_price/modules/home/atoms/currency_display.dart';
import 'package:awesome_dolar_price/modules/home/organisms/currency_display_list.dart';
import 'package:awesome_dolar_price/modules/quick_calculator/molecules/quick_calculator.dart';
import 'package:awesome_dolar_price/providers/currency_exchange_provider.dart';
import 'package:awesome_dolar_price/tokens/app/app_routes.dart';
import 'package:awesome_dolar_price/tokens/app/app_spacing.dart';
import 'package:awesome_dolar_price/tokens/atoms/app_logo.dart';
import 'package:awesome_dolar_price/tokens/mixins/consumer_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget
    with ConsumerMixin {
  const HomePage({super.key});

  @override
  Widget build(
      BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final t = AppLocalizations.of(context);

    final dolarPriceNotifier = ref.read(
        currencyExchangeNotifierProvider
            .notifier);

    Future fetchDolarPrice({
      bool forceUpdate = true,
    }) async {
      if (isLoading.value) return;

      try {
        isLoading.value = true;
        await dolarPriceNotifier.fetchPrices(
          forceUpdate: forceUpdate,
        );
        isLoading.value = false;
      } on Exception catch (e) {
        if (e is SocketException) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(
                e.message.toString(),
              ),
              duration: Duration(seconds: 5),
            ),
          );
        }
      }
      isLoading.value = false;

      /* isLoading.value = true;
      double remoteValue = await getDolarPrice(context);
      dolarPrice.value = remoteValue.toStringAsFixed(3);
      isLoading.value = false; */
    }

    useEffect(
      () {
        Future.delayed(
          Duration(milliseconds: 200),
          fetchDolarPrice,
        );

        return null;
      },
      const [],
    );

    return Scaffold(
      appBar: appBar(
        t,
        context,
        onRefresh: fetchDolarPrice,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: AppSpacing.md,
            right: AppSpacing.lg,
            left: AppSpacing.lg,
          ),
          child: Column(
            spacing: AppSpacing.lg,
            crossAxisAlignment:
                CrossAxisAlignment.center,
            mainAxisAlignment:
                MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              AppLogo.square(size: 100),
              if (isLoading.value)
                LinearProgressIndicator()
              else
                CurrencyDisplay(),
              QuickCalculator(),
              CurrencyDisplayList(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar(
    AppLocalizations t,
    BuildContext context, {
    void Function()? onRefresh,
  }) {
    return AppBar(
      title: Text(t.homeTitle),
      actions: [
        IconButton(
          onPressed: onRefresh,
          tooltip: "Refresh the prices",
          icon: const Icon(Icons.refresh_rounded),
        ),
        IconButton(
          onPressed: () => Navigator.pushNamed(
              context, AppRoutes.settings),
          icon: Icon(Icons.settings),
          tooltip: t.settingsTitle,
        ),
      ],
    );
  }
}
