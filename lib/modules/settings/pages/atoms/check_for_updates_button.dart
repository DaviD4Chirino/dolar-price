import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:doya/services/github/github_updater.dart';
import 'package:doya/tokens/app/app_flavors.dart';
import 'package:doya/tokens/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CheckForUpdatesButton extends StatefulHookWidget {
  const CheckForUpdatesButton({super.key});

  @override
  State<CheckForUpdatesButton> createState() =>
      _CheckForUpdatesButtonState();
}

class _CheckForUpdatesButtonState
    extends State<CheckForUpdatesButton> {
  final future = PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    final ThemeData theme = Theme.of(context);

    Future<void> onTap(BuildContext context) async {
      if (!AppFlavor.isGithub && !Platform.isAndroid) return;
      if (loading.value) return;
      loading.value = true;

      try {
        final hasUpdate =
            await GithubUpdater.checkForUpdatesAndroid(context);
        if (!hasUpdate) {
          if (context.mounted) {
            Flushbar(
              flushbarStyle: FlushbarStyle.GROUNDED,
              icon: Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.green,
              ),
              shouldIconPulse: false,
              message: "Ya estás en la versión más reciente",
              duration: Duration(seconds: 3),
            ).show(context);
          }
        }
      } catch (e) {
        Utils.log(e);
        if (!context.mounted) return;
        Flushbar(
          flushbarStyle: FlushbarStyle.GROUNDED,
          icon: Icon(
            Icons.error_outline_rounded,
            color: theme.colorScheme.error,
          ),
          shouldIconPulse: false,
          message: "No se pudo buscar actualizaciones",
          duration: Duration(seconds: 3),
        ).show(context);
      }

      loading.value = false;
    }

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        return ListTile(
          onTap: loading.value ? null : () => onTap(context),
          title: Text(
            loading.value
                ? "Buscando..."
                : "Buscar Actualizaciones",
          ),
          leading: const Icon(Icons.system_update_rounded),
          subtitle: Text(
            snapshot.hasData
                ? "Versión actual: v${snapshot.data!.version}"
                : "",
          ),
        );
      },
    );
  }
}
