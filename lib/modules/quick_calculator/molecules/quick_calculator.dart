import 'package:awesome_dolar_price/extensions/double_extensions/sized_box_extension.dart';
import 'package:awesome_dolar_price/modules/quick_calculator/atoms/currency_amount_input.dart';
import 'package:awesome_dolar_price/tokens/app/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuickCalculator extends ConsumerStatefulWidget {
  const QuickCalculator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuickCalculatorState();
}

class _QuickCalculatorState
    extends ConsumerState<QuickCalculator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: CurrencyAmountInput(currencyCode: "USD"),
        ),
        AppSpacing.sm.sizedBoxW,
        Icon(Icons.compare_arrows_rounded),
        AppSpacing.sm.sizedBoxW,
        Expanded(
          child: CurrencyAmountInput(currencyCode: "VES"),
        )
      ],
    );
  }
}
