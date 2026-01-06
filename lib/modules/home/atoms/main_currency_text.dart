import 'package:doya/providers/main_currency_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainCurrencyText extends ConsumerWidget {
  const MainCurrencyText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainCurrency = ref.watch(mainCurrencyProvider);
    return Text(
      mainCurrency.symbol != null
          ? "${mainCurrency.symbol} ${mainCurrency.name}"
          : mainCurrency.name,
      style: Theme.of(context).textTheme.headlineSmall,
      textAlign: TextAlign.center,
    );
  }
}
