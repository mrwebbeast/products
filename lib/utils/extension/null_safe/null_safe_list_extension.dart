extension NullSafeListExtenstion on List? {
  ///To Find that a Null List have data...
  bool get haveData {
    return ((this?.length ?? 0) > 0);
  }
}
