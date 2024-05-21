import "package:flutter/material.dart";
import "package:mrwebbeast/utils/widgets/responsive/constant.dart";

class ResponsiveBuilder extends StatelessWidget {
  final Widget mobileWidget;
  final Widget tabletWidget;
  final Widget? desktopWidget;

  const ResponsiveBuilder({
    super.key,
    required this.mobileWidget,
    required this.tabletWidget,
    this.desktopWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= kMobileBreakPoint) {
          return mobileWidget;
        } else if (constraints.maxWidth <= kTabletBreakPoint) {
          return tabletWidget;
        } else {
          return desktopWidget ?? tabletWidget;
        }
      },
    );
  }
}
