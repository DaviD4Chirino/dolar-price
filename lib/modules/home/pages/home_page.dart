import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:doya/extensions/double_extensions/sized_box_extension.dart';
import 'package:doya/l10n/app_localizations.dart';
import 'package:doya/modules/home/organisms/currency_display.dart';
import 'package:doya/modules/home/atoms/share_screenshot.dart';
import 'package:doya/modules/home/organisms/currency_display_list.dart';
import 'package:doya/modules/quick_calculator/molecules/quick_calculator.dart';
import 'package:doya/providers/currency_exchange_provider.dart';
import 'package:doya/services/github/github_updater.dart';
import 'package:doya/tokens/app/app_flavors.dart';
import 'package:doya/tokens/app/app_routes.dart';
import 'package:doya/tokens/app/app_spacing.dart';
import 'package:doya/tokens/atoms/app_logo.dart';
import 'package:doya/tokens/utils/utils.dart';
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
      currencyExchangeProvider.notifier,
    );

    Future fetchDolarPrice({
      bool forceUpdate = false,
      bool manualUpdate = false,
    }) async {
      if (isLoading.value) return;

      try {
        isLoading.value = true;
        if (manualUpdate) {
          await dolarPriceNotifier.updateUsingDolarApi();
          isLoading.value = false;
          return;
        }
        await dolarPriceNotifier.fetchPrices(
          forceUpdate: forceUpdate,
        );
        isLoading.value = false;
        if (!context.mounted) return;

        Flushbar(
          flushbarStyle: FlushbarStyle.GROUNDED,
          icon: Icon(
            Icons.check_circle_outline_rounded,
            color: Colors.green,
          ),
          shouldIconPulse: false,
          message: t.pricesUpdated,
          duration: Duration(seconds: 5),
        ).show(context);
      } on Exception catch (e) {
        if (e is SocketException) {
          Flushbar(
            flushbarStyle: FlushbarStyle.GROUNDED,
            icon: Icon(
              Icons.error_outline_rounded,
              color: theme.colorScheme.error,
            ),
            shouldIconPulse: false,
            message: e.message.toString(),
            duration: Duration(seconds: 5),
          ).show(context);
          // ignore: use_build_context_synchronously
        } else {
          Flushbar(
            flushbarStyle: FlushbarStyle.GROUNDED,
            icon: Icon(
              Icons.error_outline_rounded,
              color: theme.colorScheme.error,
            ),
            shouldIconPulse: false,
            message: e.toString(),
            duration: Duration(seconds: 5),
          ).show(context);
        }
      }
      isLoading.value = false;
    }

    useEffect(() {
      Future.delayed(Duration(milliseconds: 100), () async {
        fetchDolarPrice();

        if (AppFlavor.isGithub && Platform.isAndroid) {
          Utils.log("Checking for updates");
          try {
            if (!context.mounted) return;
            GithubUpdater.checkForUpdatesAndroid(context);
          } catch (e) {
            Utils.log(e);
          }
        }
      });
      return null;
    }, []);

    return Scaffold(
      appBar: appBar(
        t,
        context,
        onRefresh: isLoading.value ? null : fetchDolarPrice,
      ),

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
              AppLogo.square(size: 180, type: LogoType.branding),
              if (isLoading.value)
                LinearProgressIndicator()
              else
                CurrencyDisplay(),
              AppSpacing.lg.sizedBoxH,
              if (!isLoading.value) QuickCalculator(),
            ],
          ),
        ),
      ),
    );
  }
}
