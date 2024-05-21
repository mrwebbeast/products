import "dart:math";

import "package:flutter/material.dart";

const double kMobileBreakPoint = 640.0;
const double kTabletBreakPoint = 1080.0;
const double kDesktopBreakPoint = 1400.0;

double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
  final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;

  final double screenDiagonal = sqrt(pow(screenWidth, 2) + pow(screenHeight, 2));
  const double referenceDiagonal = 1400;

  double diagonalRatio = screenDiagonal / referenceDiagonal;
  diagonalRatio = max(diagonalRatio, 1);

  double textScale = diagonalRatio * (maxTextScaleFactor / devicePixelRatio);

  return min(textScale, maxTextScaleFactor);
}

num deviceSpecificValue({
  required BuildContext context,
  required num device,
  required num tablet,
  num? desktop,
}) {
  double screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth < kMobileBreakPoint) {
    return device; // Phone
  } else if (screenWidth < kTabletBreakPoint) {
    return tablet; // Tablet
  } else {
    return desktop ?? tablet; // Desktop
  }
}

class TextScaleFactor {
  static double autoScale(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
