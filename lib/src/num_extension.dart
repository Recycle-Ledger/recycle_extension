

extension NumExtension on num {
  String numberWithCommas({bool showDecimal = true, int? decimalDigit}) {
    String stringValue = toString();
    List<String> parts = stringValue.split('.');
    String integerPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
    );

    if (showDecimal && parts.length == 2) {
      String decimalPart = parts[1];
      if (decimalDigit != null && decimalDigit < decimalPart.length) {
        decimalPart = decimalPart.substring(0, decimalDigit);
      }
      return '$integerPart.$decimalPart';
    } else {
      return integerPart;
    }
  }
}

extension IntExtension on int {
  int convertASCII() {
    try {
      return int.parse(String.fromCharCode(this));
    } catch (_) {
      return 0;
    }
  }
}

extension DoubleExtension on double {
  String toStringIfZero() {
    if (this % 1 == 0) {
      return toStringAsFixed(0);
    } else {
      return toString();
    }
  }
}