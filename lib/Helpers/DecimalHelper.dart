import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalRange;
  final int integerRange;

  DecimalTextInputFormatter({required this.decimalRange, required this.integerRange})
      : assert(decimalRange >= 0, 'Decimal range must be non-negative'),
        assert(integerRange >= 0, 'Integer range must be non-negative');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String text = newValue.text;

    // Allow empty value
    if (text.isEmpty) return newValue;

    // If decimalRange is 0, do not allow any decimal point.
    if (decimalRange == 0 && text.contains('.')) {
      return oldValue;
    }

    // If user just types a ".", convert it to "0."
    if (text == ".") {
      text = "0.";
    }

    // Only allow valid number characters
    if (!RegExp(r'^\d*\.?\d*$').hasMatch(text)) {
      return oldValue;
    }

    // Split the number into integer and decimal parts if a decimal exists
    if (text.contains('.')) {
      List<String> parts = text.split('.');
      String integerPart = parts[0];
      String decimalPart = parts.length > 1 ? parts[1] : '';

      // If integer part exceeds allowed length, keep the old value
      if (integerPart.length > integerRange) {
        return oldValue;
      }

      // If decimal part exceeds allowed length, keep the old value
      if (decimalPart.length > decimalRange) {
        return oldValue;
      }
    } else {
      // No decimal point: check if the entire number exceeds allowed integer digits
      if (text.length > integerRange) {
        return oldValue;
      }
    }

    return newValue.copyWith(text: text, selection: newValue.selection);
  }
}
