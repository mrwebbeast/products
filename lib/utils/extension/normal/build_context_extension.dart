import "package:flutter/material.dart";


/// 1) Navigation Extensions...
extension Navigation on BuildContext {
  Future navigateTo({required Widget child}) {
    return Navigator.of(this).push(MaterialPageRoute(builder: (context) => child)).then((value) => value);
  }

  Future navigateToReplacement({required Widget child}) {
    return Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (context) => child)).then((value) => value);
  }

  void popUntil({required Widget child}) {
    return Navigator.of(this).popUntil((route) => route.isFirst);
  }

  void navigateBack() {
    return Navigator.of(this).pop();
  }
}

/// 2) AppSize Extensions...
extension AppSize on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;
}

/// 3) AppTheme Extensions...
extension AppTheme on BuildContext {
  ThemeData get theme => Theme.of(this);

  bool get darkMode => Theme.of(this).brightness == Brightness.dark;

  Color get containerColor => Theme.of(this).brightness == Brightness.dark ? Colors.black : Colors.white;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;


}
