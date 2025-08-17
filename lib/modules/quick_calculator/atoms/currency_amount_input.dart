import 'package:awesome_dolar_price/modules/quick_calculator/tokens/formatters/remove_leading_zeroes.dart';
import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        LeadingZeroInputFormatter()
      ],
      decoration: InputDecoration(
        label: CurrencyToSymbolWidget(
          currencyCode: currencyCode,
        ),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(Icons.copy_rounded),
        ),
      ),
    );
  }
}
