extension StringExtension on String {
  /// Converts the numbers in text, into a VES numerical format like
  /// 12,345,678.90
  String toVES() {
    double? isNumber = double.tryParse(this);
    if (isNumber == null) {
      throw Exception("$this is not a number, cannot proceed");
    }

    // separate decimals with whole number, and take the whole
    var decimals = split(".").last;
    var whole = split(".").first;

    var reversedWhole = String.fromCharCodes(
      whole.runes.toList().reversed,
    );

    var withCommas = reversedWhole.replaceAllMapped(
      RegExp(r".{1,3}"),
      (match) => ".${match.group(0)}",
    );

    var unReversed = String.fromCharCodes(
      withCommas.runes.toList().reversed,
    );

    if (unReversed.endsWith(".")) {
      unReversed = unReversed.replaceRange(
        unReversed.length - 1,
        null,
        "",
      );
    }

    var formatted =
        "$unReversed${decimals == whole || decimals.isEmpty ? "" : ",$decimals"}";

    return formatted;
  }
}
