import 'package:doya/tokens/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CurrenciesSelectionPage extends HookWidget {
  const CurrenciesSelectionPage({super.key});
  static final List<String> dummyCurrencies = [
    "USD",
    "EUR",
    "CNY",
    "RUB",
    "JPY",
    "GBP",
    "INR",
    "CAD",
    "AUD",
    "BRL",
    "CHF",
    "HKD",
    "MXN",
    "NOK",
    "NZD",
    "TRY",
    "ZAR",
    "SEK",
    "DKK",
    "PLN",
    "CZK",
    "HUF",
    "ILS",
    "IDR",
    "MYR",
    "PHP",
    "THB",
    "RON",
    "SGD",
    "BGN",
    "HRK",
    "KRW",
    "AED",
    "ARS",
    "BOB",
    "CLP",
    "COP",
    "CRC",
    "CUP",
    "DOP",
    "EGP",
    "GTQ",
    "HNL",
    "ISK",
    "JMD",
    "KZT",
    "LAK",
    "LYD",
    "MOP",
    "MXV",
    "MYT",
    "NIO",
    "PAB",
    "PEN",
    "PHP",
    "QAR",
    "SAR",
    "SGD",
    "SRD",
    "TTD",
    "TWD",
    "VEF",
    "VND",
    "XAF",
    "XCD",
    "XOF",
    "YER",
  ];

  @override
  Widget build(BuildContext context) {
    var searchController = useTextEditingController();
    var selectedCurrencies = useState<List<String>>([]);
    var maxAmount = useState<int>(5);
    var selectedAmount = useState<int>(0);

    void onCurrencySelected(String currency) {
      if (!selectedCurrencies.value.contains(currency) &&
          selectedAmount.value < maxAmount.value) {
        selectedCurrencies.value = [
          ...selectedCurrencies.value,
          currency,
        ];
      } else {
        selectedCurrencies.value = [
          ...selectedCurrencies.value..remove(currency),
        ];
      }
      selectedAmount.value = selectedCurrencies.value.length;
      Utils.log(selectedCurrencies.value);
    }

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Seleccionar monedas"),
          subtitle: Text(
            'Has elegido ${selectedAmount.value} de ${maxAmount.value} monedas',
          ),
        ),
      ),
      body: Column(
        children: [
          SearchBar(controller: searchController),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                var dummyCurrency = dummyCurrencies[index];
                var isSelected = selectedCurrencies.value
                    .contains(dummyCurrency);

                return ListTile(
                  enabled:
                      selectedAmount.value < maxAmount.value,
                  title: Text(dummyCurrency),
                  onTap: () => onCurrencySelected(dummyCurrency),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      if (value == null) return;
                      onCurrencySelected(dummyCurrency);
                    },
                  ),
                );
              },
              itemCount: dummyCurrencies.length,
            ),
          ),
        ],
      ),
    );
  }
}
