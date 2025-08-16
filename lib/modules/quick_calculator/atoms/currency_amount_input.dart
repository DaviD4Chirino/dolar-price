import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:flutter/material.dart';

class CurrencyAmountInput extends StatelessWidget {
  const CurrencyAmountInput({
    super.key,
    required this.currencyCode,
  });

  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "0.00",
        label: CurrencyToSymbolWidget(
          currencyCode: currencyCode,
        ),
      ),
    );
  }
}
