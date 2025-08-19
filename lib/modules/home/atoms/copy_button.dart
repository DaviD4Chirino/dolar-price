import 'package:awesome_dolar_price/tokens/app/app_sizing.dart';
import 'package:awesome_dolar_price/tokens/utils/helpers/copy_to_clipboard.dart';
import 'package:flutter/material.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({super.key, required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Align(
        alignment: Alignment.centerRight,
        child: Transform.translate(
          offset: const Offset(-7, 4),
          child: IconButton(
            onPressed: () {
              copyToClipboard(
                "${value.toStringAsFixed(3)}Bs",
                context: context,
              );
            },
            icon: Icon(Icons.copy_rounded),
            iconSize: AppSizing.md,
          ),
        ),
      ),
    );
  }
}
