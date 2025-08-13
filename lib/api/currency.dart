import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getCurrency(String code) async {
  final response = await http.get(
    // I had no idea this api existed, i was planning on scrapping https://www.bcv.org.ve
    Uri.parse("https://open.er-api.com/v6/latest/$code"),
  );
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    if (json["result"] == "error") {
      throw Exception("Api Error: ${json["error-type"]}");
    }
    return json;
  }
  throw SocketException("Could not get dolar price");
}
