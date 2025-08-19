import 'package:awesome_dolar_price/modules/home/atoms/copy_button.dart';
import 'package:awesome_dolar_price/modules/home/molecule/current_rate_info.dart';
import 'package:awesome_dolar_price/providers/currency_exchange_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrencyDisplay extends ConsumerWidget {
  const CurrencyDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dolarPriceProvider = ref.watch(
      currencyExchangeNotifierProvider,
    );

    return Stack(
      children: [
        CurrentRateInfo(),

        CopyButton(value: dolarPriceProvider.rates.usd),
      ],
    );
  }
}
