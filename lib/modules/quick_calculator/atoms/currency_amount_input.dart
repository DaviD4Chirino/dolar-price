import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:flutter/material.dart';

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
      decoration: InputDecoration(
        label: CurrencyToSymbolWidget(
          currencyCode: currencyCode,
        ),
      ),
    );
  }
}
