import 'dart:async';
import 'dart:io';

import 'package:awesome_dolar_price/extensions/double_extensions/sized_box_extension.dart';
import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:awesome_dolar_price/modules/home/organisms/currency_display.dart';
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
import 'package:layout/layout.dart';
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

    Future fetchDolarPrice({bool forceUpdate = false}) async {
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
            content: Text(t.pricesUpdated),
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
      Future.delayed(
        Duration(milliseconds: 200),
        fetchDolarPrice,
      );

      timer = Timer.periodic(Duration(hours: 1, seconds: 1), (
        timer,
      ) {
        fetchDolarPrice(forceUpdate: false);
      });

      return () {
        timer?.cancel();
      };
    }, const []);

    return Scaffold(
      appBar: appBar(t, context, onRefresh: fetchDolarPrice),
      body: context.breakpoint > LayoutBreakpoint.xs
          ? HomePageLandscape(
              screenshotController: screenshotController,
              theme: theme,
              isLoading: isLoading,
            )
          : HomePagePortrait(
              screenshotController: screenshotController,
              theme: theme,
              isLoading: isLoading,
            ),
    );
  }

  AppBar appBar(
    AppLocalizations t,
    BuildContext context, {
    void Function()? onRefresh,
  }) {
    return AppBar(
      actions: [
        ShareScreenshot(
          screenshotController: screenshotController,
        ),
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

class HomePageLandscape extends StatelessWidget {
  const HomePageLandscape({
    super.key,
    required this.screenshotController,
    required this.theme,
    required this.isLoading,
  });
  final ScreenshotController screenshotController;
  final ThemeData theme;
  final ValueNotifier<bool> isLoading;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppSpacing.lg,
      children: [
        Expanded(
          flex: 6,
          child: SingleChildScrollView(
            child: Center(
              child: MainCurrencyHeadline(
                screenshotController: screenshotController,
                isLoading: isLoading,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child: SingleChildScrollView(
              child: CurrencyDisplayList(),
            ),
          ),
        ),
        AppSpacing.xl.sizedBoxH,
      ],
    );
  }
}

class HomePagePortrait extends StatelessWidget {
  const HomePagePortrait({
    super.key,
    required this.screenshotController,
    required this.theme,
    required this.isLoading,
  });

  final ScreenshotController screenshotController;
  final ThemeData theme;
  final ValueNotifier<bool> isLoading;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          MainCurrencyHeadline(
            screenshotController: screenshotController,
            isLoading: isLoading,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSpacing.lg.sizedBoxH,
                CurrencyDisplayList(),
                AppSpacing.lg.sizedBoxH,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainCurrencyHeadline extends StatelessWidget {
  const MainCurrencyHeadline({
    super.key,
    required this.screenshotController,
    required this.isLoading,
  });

  final ScreenshotController screenshotController;
  final ValueNotifier<bool> isLoading;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Screenshot(
      controller: screenshotController,
      child: Container(
        color: theme.colorScheme.surfaceContainerLow,

        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AppSpacing.xs.sizedBoxH,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.164),
                      blurRadius: 18,
                      spreadRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: AppLogo.square(size: 100),
              ),
              AppSpacing.lg.sizedBoxH,
              if (isLoading.value)
                LinearProgressIndicator()
              else
                CurrencyDisplay(),
              AppSpacing.lg.sizedBoxH,
              QuickCalculator(),
            ],
          ),
        ),
      ),
    );
  }
}
