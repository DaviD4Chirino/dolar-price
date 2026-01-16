import 'package:doya/tokens/extensions/string/to_ves.dart';
import 'package:flutter/services.dart';

class TextCurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Make sure its a number
    if (double.tryParse(newValue.text) == null) {
      return oldValue;
    }

    final newFormattedText = newValue.text.toVES();

    final calculatedTextSelection = calculateSelectionOffset(
      oldValue: oldValue,
      newValue: newValue,
      newText: newFormattedText,
      maxFormattedLength: 9999999,
    );

    return newValue.copyWith(
      text: newValue.text.toVES(),
      selection: calculatedTextSelection,
    );
  }
}

TextSelection? calculateSelectionOffset({
  required TextEditingValue oldValue,
  required TextEditingValue newValue,
  required String newText,
  required int maxFormattedLength,
}) {
  final oldOffset = oldValue.selection.baseOffset;
  final newOffset = newValue.selection.baseOffset;

  // Prevent the "range start is out of text of length" error
  if (newOffset > newText.length || oldOffset > newText.length) {
    return TextSelection.collapsed(offset: newText.length);
  }

  // If the old offset equals the length of the old text, it shifts the offset to the end of the new text
  if (oldValue.text.length == oldOffset) {
    return TextSelection.collapsed(offset: newText.length);
  }

  final newTextUntilOldOffset = newText.substring(0, oldOffset);
  final newTextUntilNewOffset = newText.substring(0, newOffset);
  final spaceDifference = countSpaceDif(
    newTextUntilNewOffset,
    newTextUntilOldOffset,
  );
  // Adjust the offset by increasing it based on the difference in spaces
  if (spaceDifference > 0) {
    return TextSelection.collapsed(
      offset: newOffset + spaceDifference,
    );
  }

  // Reduce the selection offset by one if a digit following a space is removed
  if (newOffset != 0 && newValue.text[newOffset - 1] == ' ') {
    return TextSelection.collapsed(offset: newOffset - 1);
  }

  // Return null and use default selection behavior
  return null;
}

int countSpaceDif(
  String newTextUntilNewOffset,
  String newTextUntilOldOffset,
) {
  return ' '.allMatches(newTextUntilNewOffset).length -
      ' '.allMatches(newTextUntilOldOffset).length;
}
