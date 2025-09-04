import 'package:doya/extensions/double_extensions/sized_box_extension.dart';
import 'package:doya/modules/home/atoms/currency_value_title.dart';
import 'package:doya/modules/home/atoms/main_currency_text.dart';
import 'package:doya/modules/home/molecule/current_rate_info.dart';
import 'package:doya/tokens/app/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrencyDisplay extends ConsumerWidget {
  const CurrencyDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainCurrencyText(),
        AppSpacing.xs.sizedBoxH,
        CurrencyValueTitle(),
        AppSpacing.md.sizedBoxH,
        CurrentRateInfo(),
      ],
    );
  }
}
