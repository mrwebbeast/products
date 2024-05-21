extension StringExtenstion on String {
  ///To Find that a Null List have data...
  String get toCapitalizeFirst {
    String text;
    if (length >= 1) {
      text = "${this[0].toUpperCase()}${substring(1, length)}";
    } else {
      text = toUpperCase();
    }

    return text;
  }
}
