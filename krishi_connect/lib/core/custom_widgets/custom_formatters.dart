import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class IndianPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(" ", "");

    if (digits.length > 10) digits = digits.substring(0, 10);

    String formatted = digits.length <= 5
        ? digits
        : digits.substring(0, 5) + " " + digits.substring(5);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

// Format function
String formatDate(DateTime dt) {
  return DateFormat('d MMM HH:mm').format(dt.toLocal());
}

String formatTime(DateTime dt) {
  return DateFormat('HH:mm').format(dt.toLocal());
}

final rupees = NumberFormat.currency(
  locale: 'en_IN',
  symbol: '₹',
  decimalDigits: 0,
);
