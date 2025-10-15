import 'package:doya/tokens/models/update_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher_string.dart';

class UpdateAlertDialog extends StatelessWidget {
  const UpdateAlertDialog(this.updateData, {super.key});

  final UpdateData updateData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Nueva Actualización Disponible (${updateData.versionString})",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancelar"),
        ),
        FilledButton(
          onPressed: onPressed,
          child: Text("Descargar"),
        ),
      ],
      content: Html(
        data: md.markdownToHtml(updateData.body),
        onLinkTap: (url, map, el) {
          if (url != null) launchUrlString(url);
        },
      ),
    );
  }

  void onPressed() {
    if (updateData.downloadUrl.isEmpty) {
      if (kDebugMode) {
        print(updateData.pageUrl);
      }
      launchUrlString(updateData.pageUrl);
      return;
    }
    if (kDebugMode) {
      print(updateData.downloadUrl);
    }
    launchUrlString(updateData.downloadUrl);
  }
}
