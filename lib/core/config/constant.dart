

import "package:flutter/material.dart";
import "package:flutter/services.dart";

// Dimensions

const double paddingSmall = 8.0;
const double paddingMedium = 16.0;
const double paddingLarge = 24.0;


class Screens {
  static double heigth(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double statusbarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static bool isMobile(BuildContext context) {
    if (MediaQuery.of(context).size.width < 728.0) {
      return true;
    } else {
      return false;
    }
  }

  static bool isPortrait(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return true;
    } else {
      return false;
    }
  }

  static bool isLandscape(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> hideSystemBars() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static Future<void> showSystemBars() async {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  static double logoSize(BuildContext context) {
    if (Screens.isPortrait(context)) {
      return Screens.heigth(context) * 0.05;
    } else {
      return Screens.width(context) * 0.05;
    }
  }

  static Future<void> setPortrait() async {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
  }

  static Future<void> setLandscape() async {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );
  }

  static Future<void> resetOrientation() async {
    SystemChrome.setPreferredOrientations([]);
  }
}