import 'package:awesome_dolar_price/tokens/utils/helpers/percentage_calculator.dart';
import 'package:flutter/material.dart';

class CurrencyComparison extends StatelessWidget {
  const CurrencyComparison({
    super.key,
    required this.lastRate,
    required this.currentRate,
  });

  final double lastRate;
  final double currentRate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final growth = percentageChange(lastRate, currentRate);

    final amountChanged = (currentRate - lastRate);

    final color = amountChanged == 0
        ? null
        : amountChanged > 0
        ? theme.colorScheme.error
        : Colors.green;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (amountChanged != 0)
          Icon(
            amountChanged > 0
                ? Icons.arrow_upward_rounded
                : Icons.arrow_downward_rounded,
            color: color,
            size: 16,
          ),
        Text(
          "${amountChanged.toStringAsFixed(2)}bs (${growth.toStringAsFixed(1)}%)",
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
