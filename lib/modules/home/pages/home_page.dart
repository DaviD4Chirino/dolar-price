import 'dart:async';
import 'dart:io';

import 'package:awesome_dolar_price/extensions/double_extensions/sized_box_extension.dart';
import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:awesome_dolar_price/modules/home/atoms/currency_display.dart';
import 'package:awesome_dolar_price/modules/home/atoms/share_screenshot.dart';
import 'package:awesome_dolar_price/modules/home/organisms/currency_display_list.dart';
import 'package:awesome_dolar_price/modules/quick_calculator/molecules/quick_calculator.dart';
import 'package:awesome_dolar_price/providers/currency_exchange_provider.dart';
import 'package:awesome_dolar_price/tokens/app/app_routes.dart';
import 'package:awesome_dolar_price/tokens/app/app_spacing.dart';
import 'package:awesome_dolar_price/tokens/atoms/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:screenshot/screenshot.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScreenshotController screenshotController =
      ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final t = AppLocalizations.of(context);
    final ThemeData theme = Theme.of(context);

    final dolarPriceNotifier = ref.read(
      currencyExchangeNotifierProvider.notifier,
    );

    Timer? timer;

    Future fetchDolarPrice({bool forceUpdate = true}) async {
      if (isLoading.value) return;

      try {
        isLoading.value = true;
        await dolarPriceNotifier.fetchPrices(
          forceUpdate: forceUpdate,
        );
        isLoading.value = false;
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Dolar price updated"),
            duration: Duration(seconds: 5),
          ),
        );
      } on Exception catch (e) {
        if (e is SocketException) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message.toString()),
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

    useEffect(() {
      Future.delayed(Duration(milliseconds: 200), fetchDolarPrice);

      timer = Timer.periodic(Duration(hours: 1, seconds: 1), (timer) {
        fetchDolarPrice(forceUpdate: false);
      });

      return () {
        timer?.cancel();
      };
    }, const []);

    return Scaffold(
      appBar: appBar(t, context, onRefresh: fetchDolarPrice),
      body: Screenshot(
        controller: screenshotController,
        child: SingleChildScrollView(
          child: Container(
            color: theme.colorScheme.surfaceContainerLowest,
            child: Padding(
              padding: EdgeInsets.only(
                top: AppSpacing.md,
                right: AppSpacing.lg,
                left: AppSpacing.lg,
              ),
              child: Column(
                spacing: AppSpacing.lg,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AppLogo.square(size: 100),
                  if (isLoading.value)
                    LinearProgressIndicator()
                  else
                    CurrencyDisplay(),
                  QuickCalculator(),
                  AppSpacing.xs.sizedBoxH,
                  CurrencyDisplayList(),
                  AppSpacing.md.sizedBoxH,
                ],
              ),
            ),
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
        ShareScreenshot(screenshotController: screenshotController),
        IconButton(
          onPressed: onRefresh,
          tooltip: t.refreshPrices,
          icon: const Icon(Icons.refresh_rounded),
        ),
        IconButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.settings),
          icon: Icon(Icons.settings),
          tooltip: t.settingsTitle,
        ),
      ],
    );
  }
}
