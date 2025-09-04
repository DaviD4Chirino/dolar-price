import 'package:doya/l10n/app_localizations.dart';
import 'package:doya/modules/settings/molecules/currency_selector_dialog.dart';
import 'package:doya/providers/main_currency_provider.dart';
import 'package:doya/tokens/models/currencies.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainCurrencySelector extends ConsumerWidget {
  const MainCurrencySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final mainCurrency = ref.watch(mainCurrencyNotifierProvider);

    return ListTile(
      onTap: () => showDialog(
        context: context,
        builder: (context) => CurrencySelectorDialog(),
      ),
      leading: Icon(Icons.currency_exchange_rounded),
      title: Text(t.settingsChangeMainCurrencyTitle),
      subtitle: Text(
        Currencies.getCurrencyTitle(
          mainCurrency,
          context: context,
        ),
      ),
    );
  }
}
