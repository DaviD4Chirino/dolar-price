import 'dart:convert';

import 'package:awesome_dolar_price/tokens/models/quotes.dart';
import 'package:awesome_dolar_price/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:awesome_dolar_price/tokens/utils/modules/local_storage/models/local_storage_paths.dart';

Future<void> saveQuote(Quotes quote) async {
  var quotes = getQuotes() ?? [];
  quotes.add(quote);

  return saveQuotes(quotes);
}

Future<void> saveQuotes(List<Quotes> quotes) async {
  /// Keep only the last 50 quotes
  if (quotes.length > 50) {
    quotes.removeRange(0, quotes.length - 50);
  }

  return LocalStorage.setStringList(
    LocalStoragePaths.currencyQuotes,
    quotes.map((e) => jsonEncode(e.toJson())).toList(),
  );
}

List<Quotes>? getQuotes() {
  var existingQuotes = LocalStorage.getStringList(
    LocalStoragePaths.currencyQuotes,
  );

  if (existingQuotes != null) {
    return existingQuotes
        .map((e) => Quotes.fromJson(jsonDecode(e)))
        .toList();
  }
  return null;
}
