import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";


import "package:mrwebbeast/utils/theme/colors.dart";

class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet({
    super.key,
    this.title,
    this.subTitle,
    required this.body,
    required this.showTitleDivider,
    this.physics,
    this.constraints,
    this.centerTitle,
    this.bottomNavBar,
    this.bottomNavBarAlignment,
    this.margin,
    this.borderRadius,
    this.bottomNavBarHeight,
    this.appBar,
    this.mainAxisSize,
    this.showBackButton,
  });

  final String? title;
  final String? subTitle;
  final Widget body;

  final Widget? appBar;
  final Widget? bottomNavBar;
  final double? bottomNavBarHeight;
  final BoxConstraints? constraints;
  final MainAxisSize? mainAxisSize;
  final Alignment? bottomNavBarAlignment;
  final ScrollPhysics? physics;
  final bool? showTitleDivider;
  final EdgeInsets? margin;
  final bool? centerTitle;
  final bool? showBackButton;
  final double? borderRadius;

  static show({
    required BuildContext context,
    String? title,
    String? subTitle,
    required Widget body,
    bool? showTitleDivider,
    bool? isScrollControlled,
    bool? isDismissible,
    bool? enableDrag,
    bool? showBackButton,
    bool? centerTitle,
    EdgeInsets? margin,
    ScrollPhysics? physics,
    BoxConstraints? constraints,
    Widget? appBar,
    MainAxisSize? mainAxisSize,
    Widget? bottomNavBar,
    double? borderRadius,
    double? bottomNavBarHeight,
    Alignment? bottomNavBarAlignment,
  }) async {
    double defaultBorderRadius = borderRadius ?? 18;
    return showModalBottomSheet(
        context: context,
        clipBehavior: Clip.none,
        isScrollControlled: isScrollControlled ?? true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultBorderRadius),
            topRight: Radius.circular(defaultBorderRadius),
          ),
        ),
        backgroundColor: context.containerColor,
        useSafeArea: true,
        isDismissible: isDismissible ?? true,
        enableDrag: enableDrag ?? true,
        builder: (context) {
          return AppBottomSheet(
            title: title,
            subTitle: subTitle,
            body: body,
            showTitleDivider: showTitleDivider,
            physics: physics,
            centerTitle: centerTitle,
            constraints: constraints,
            bottomNavBar: bottomNavBar,
            margin: margin,
            appBar: appBar,
            showBackButton: showBackButton,
            mainAxisSize: mainAxisSize,
            borderRadius: defaultBorderRadius,
            bottomNavBarHeight: bottomNavBarHeight,
            bottomNavBarAlignment: bottomNavBarAlignment,
          );
        });
  }

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  late String? title = widget.title;
  late String? subTitle = widget.subTitle;
  late Widget body = widget.body;
  late Widget? appBar = widget.appBar;
  late Widget? bottomNavBar = widget.bottomNavBar;
  late double? bottomNavBarHeight = widget.bottomNavBarHeight;
  late bool showTitleDivider = widget.showTitleDivider ?? true;
  late bool centerTitle = widget.centerTitle ?? false;
  late bool showBackButton = widget.showBackButton ?? false;
  late ScrollPhysics? physics = widget.physics;
  late EdgeInsets? margin = widget.margin;
  late BoxConstraints? constraints = widget.constraints;
  late Alignment? bottomNavBarAlignment = widget.bottomNavBarAlignment;
  late MainAxisSize? mainAxisSize = widget.mainAxisSize;
  late double borderRadius = widget.borderRadius ?? 18;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          constraints: constraints,
          decoration: BoxDecoration(
            color: context.containerColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
          ),
          child: Stack(
            alignment: bottomNavBarAlignment ?? Alignment.bottomCenter,
            children: [
              Column(
                mainAxisSize: mainAxisSize ?? MainAxisSize.min,
                children: [
                  if (title != null)
                    Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 24, right: 8, top: 10, bottom: showTitleDivider ? 8 : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (centerTitle == true) const SizedBox(width: 24),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "$title",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    if (showBackButton == true)
                                      GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          context.pop();
                                        },
                                        child: const Icon(
                                          CupertinoIcons.multiply,
                                          color: primaryColor,
                                        ),
                                      )
                                    else
                                      const SizedBox(),
                                  ],
                                ),
                              ),
                              if (subTitle != null)
                                Text(
                                  "$subTitle",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                            ],
                          ),
                        ),
                        if (showTitleDivider)
                          const Divider(
                            height: 0,
                            thickness: 1,
                          ),
                      ],
                    ),
                  if (appBar != null) appBar!,
                  Flexible(
                    child: ListView(
                      physics: physics ?? const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      children: [
                        body,
                      ],
                    ),
                  ),
                  if (bottomNavBar != null) SizedBox(height: bottomNavBarHeight ?? 0),
                ],
              ),
              if (bottomNavBar != null) bottomNavBar!,
            ],
          ),
        ),
      ),
    );
  }
}
