import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pasteboard/pasteboard.dart';
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
      // Force Portrait Mode
      /* await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]); */
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
      if (Platform.isAndroid ||
          Platform.isIOS ||
          Platform.isWindows) {
        await Pasteboard.writeFiles([file.path]);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Foto copiada al portapapeles",
            ), // Optional: add a sharing error message key to your l10n
            duration: Duration(seconds: 4),
          ),
        );
      }

      var params = ShareParams(files: [XFile(file.path)]);
      await SharePlus.instance.share(params);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ), // Optional: add a sharing error message key to your l10n
          duration: Duration(seconds: 4),
        ),
      );
      if (kDebugMode) {
        print(e);
      }
    }

    // Reset Portrait Mode
    /* await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]); */
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onShare(context),
      tooltip: "Compartir captura de pantalla",
      icon: const Icon(Icons.share_rounded),
    );
  }
}
