import 'package:currency_textfield/currency_textfield.dart';
import 'package:doya/extensions/double_extensions/sized_box_extension.dart';
import 'package:doya/modules/quick_calculator/atoms/currency_amount_input.dart';
import 'package:doya/providers/currency_exchange_provider.dart';
import 'package:doya/providers/main_currency_provider.dart';
import 'package:doya/services/exchange_rate/models/supported_currency.dart';
import 'package:doya/tokens/app/app_spacing.dart';
import 'package:doya/tokens/models/quotes.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuickCalculator extends ConsumerStatefulWidget {
  const QuickCalculator({super.key});

  @override
  ConsumerState<QuickCalculator> createState() =>
      _QuickCalculatorState();
}

class _QuickCalculatorState
    extends ConsumerState<QuickCalculator> {
  final currencyTextController = TextEditingController();
  final bsTextController = CurrencyTextFieldController(
    thousandSymbol: ".",
    decimalSymbol: ",",
    removeSymbol: true,
  );

  Quotes get dolarPriceProvider =>
      ref.read(currencyExchangeProvider);
  SupportedCurrency get mainCurrency =>
      ref.watch(mainCurrencyProvider);

  bool _isUpdating = false;

  void onCurrencyChanged(String value) {
    if (_isUpdating) return;
    _isUpdating = true;

    final currencyAmount = double.tryParse(value) ?? 0;
    final bsValue = dolarPriceProvider.rates.convertRate(
      mainCurrency,
      currencyAmount,
    );

    // Update the other controller if needed
    if (bsTextController.text != bsValue.toStringAsFixed(2)) {
      bsTextController.text = bsValue.toStringAsFixed(2);
    }

    _isUpdating = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currencyTextController.text = "1";
    onCurrencyChanged("1");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      if (!mounted) return;
      currencyTextController.text = "1";
      onCurrencyChanged("1");
    });
  }

  @override
  void dispose() {
    currencyTextController.dispose();
    bsTextController.dispose();
    super.dispose();
  }

  void onBsChanged(String value) {
    if (_isUpdating) return;
    _isUpdating = true;

    final bsAmount =
        double.tryParse(
          value.replaceAll(".", "").replaceAll(",", "."),
        ) ??
        0;
    final currencyValue = dolarPriceProvider.rates.convertRate(
      mainCurrency,
      bsAmount,
      reverse: true,
    );

    // Update the other controller if needed
    if (currencyTextController.text !=
        currencyValue.toStringAsFixed(2)) {
      currencyTextController.text = currencyValue
          .toStringAsFixed(2);
    }

    _isUpdating = false;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(mainCurrencyProvider, (prev, next) {
      // When mainCurrency changes, update fields
      currencyTextController.text = "1";
      onCurrencyChanged("1");
    });

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: CurrencyAmountInput(
            currencyCode:
                '${mainCurrency.symbol ?? ""} (${mainCurrency.code})',
            controller: currencyTextController,
            onChanged: onCurrencyChanged,
          ),
        ),
        AppSpacing.sm.sizedBoxW,
        Icon(Icons.compare_arrows_rounded),
        AppSpacing.sm.sizedBoxW,
        Expanded(
          child: CurrencyAmountInput(
            currencyCode: "Bs.",
            controller: bsTextController,
            onChanged: onBsChanged,
          ),
        ),
      ],
    );
  }
}
