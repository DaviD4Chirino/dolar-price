import 'dart:io';

import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ShareScreenshot extends StatelessWidget {
  const ShareScreenshot({
    super.key,
    required this.screenshotController,
  });

  final ScreenshotController screenshotController;

  Future<void> onShare(BuildContext context) async {
    try {
      var screenshot = await screenshotController.capture(
        delay: Duration(seconds: 1),
      );
      if (screenshot == null) return;

      // Save image to a temporary file
      final tempDir = await Directory.systemTemp.createTemp();
      final file = File(
        '${tempDir.path}/dolar_price_screenshot.png',
      );
      await file.writeAsBytes(screenshot);

      var params = ShareParams(files: [XFile(file.path)]);
      SharePlus.instance.share(params);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "There was an error while sharing the screenshot",
          ), // Optional: add a sharing error message key to your l10n
          duration: Duration(seconds: 4),
        ),
      );
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return IconButton(
      onPressed: () => onShare(context),
      tooltip: t.shareThisPage,
      icon: const Icon(Icons.share_rounded),
    );
  }
}
