extension NullSafeStringExtenstion on String? {
  ///To Find that a Null List have data...
  String? get toCapitalizeFirst {
    String? text;
    if ((this?.length ?? 0) >= 1) {
      text = "${this?[0].toUpperCase()}${this?.substring(1, this?.length ?? 0)}";
    } else {
      text = this?.toUpperCase();
    }

    return text;
  }
}
