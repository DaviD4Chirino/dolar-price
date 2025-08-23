import 'package:awesome_dolar_price/modules/quick_calculator/tokens/formatters/remove_leading_zeroes.dart';
import 'package:awesome_dolar_price/tokens/models/currencies.dart';
import 'package:awesome_dolar_price/tokens/utils/helpers/copy_to_clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A text field that allows only numbers and a dot
/// Also, it has an icon to copy the value to the clipboard
/// but only if the controller is not null
class CurrencyAmountInput extends StatelessWidget {
  const CurrencyAmountInput({
    super.key,
    required this.currencyCode,
    this.controller,
    this.onChanged,
  });

  final String currencyCode;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        LeadingZeroInputFormatter(),
      ],
      decoration: InputDecoration(
        label: Text(
          Currencies.getCurrencyTitle(
            currencyCode,
            context: context,
          ),
        ),

        suffixIcon: IconButton(
          onPressed: controller != null
              ? () => copyToClipboard(
                  controller?.text ?? "",
                  context: context,
                )
              : null,
          icon: Icon(Icons.copy_rounded),
        ),
      ),
    );
  }
}
