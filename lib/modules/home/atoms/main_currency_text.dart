import 'package:doya/providers/main_currency_provider.dart';
import 'package:doya/tokens/models/currencies.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainCurrencyText extends ConsumerWidget {
  const MainCurrencyText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final mainCurrency = ref.watch(mainCurrencyProvider);
    return Text(
      "USD",
      style: Theme.of(context).textTheme.headlineSmall,
      textAlign: TextAlign.center,
    );
  }
}
