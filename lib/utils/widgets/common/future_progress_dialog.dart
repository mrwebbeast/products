import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:mrwebbeast/core/config/app_assets.dart";
import "package:mrwebbeast/utils/widgets/image/image_view.dart";

Future loadingDialog({
  required BuildContext context,
  required Future future,
  String? message,
}) async {
  return await showDialog(
    context: context,
    builder: (context) => FutureProgressDialog(
      future,
      message: message != null ? Text("$message...") : null,
    ),
  );
}

class FutureProgressDialog extends StatefulWidget {
  /// Dialog will be closed when [future] task is finished.
  @required
  final Future future;

  /// [BoxDecoration] of [FutureProgressDialog].
  final BoxDecoration? decoration;

  /// opacity of [FutureProgressDialog]
  final double opacity;

  /// If you want to use custom progress widget set [progress].
  final Widget? progress;

  /// If you want to use message widget set [message].
  final Widget? message;
  final Widget? child;

  const FutureProgressDialog(
    this.future, {
    super.key,
    this.decoration,
    this.opacity = 1.0,
    this.progress,
    this.message,
    this.child,
  });

  @override
  FutureProgressDialogState createState() => FutureProgressDialogState();
}

class FutureProgressDialogState extends State<FutureProgressDialog> {
  @override
  Future<void> initState() async {
    super.initState();
    widget.future.then((val) {
      context.pop(val);
    }).catchError((e) {
      context.pop();
      throw e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (status) async {},
      child: _buildDialog(context),
    );
  }

  Widget _buildDialog(BuildContext context) {
    Widget content;
    if (widget.message == null) {
      content = Center(
        child: Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          decoration: widget.decoration ?? _defaultDecoration,
          child: widget.progress ?? const CircularProgressIndicator(),
        ),
      );
    } else {
      content = Container(
        height: 100,
        padding: const EdgeInsets.all(20),
        decoration: widget.decoration ?? _defaultDecoration,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          widget.progress ?? const CircularProgressIndicator(),
          const SizedBox(width: 20),
          _buildText(context)
        ]),
      );
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: widget.child != null ? EdgeInsets.zero : null,
      elevation: 0,
      child: Opacity(
        opacity: widget.opacity,
        child: widget.child ?? content,
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    if (widget.message == null) {
      return const SizedBox.shrink();
    }
    return Expanded(
      flex: 1,
      child: widget.message!,
    );
  }
}

class CustomPopupUI extends StatefulWidget {
  const CustomPopupUI(
      {super.key,
      required this.title,
      required this.message,
      this.image,
      this.descriptionFontSize,
      this.onWillPop});

  final String title;
  final String message;

  final String? image;
  final double? descriptionFontSize;
  final GestureTapCallback? onWillPop;

  @override
  State<CustomPopupUI> createState() => _CustomPopupUIState();
}

class _CustomPopupUIState extends State<CustomPopupUI> {
  bool? onDismiss;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onWillPop,
      child: SimpleDialog(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0.0))),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 36),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(40)),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    ImageView(
                      height: 200,
                      width: 300,
                      fit: BoxFit.contain,
                      borderRadiusValue: 0,
                      margin: const EdgeInsets.only(top: 48),
                      assetImage: widget.image ?? AppAssets.appIcon,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(42, 8, 42, 24),
                      child: Text(
                        widget.message,
                        style: TextStyle(
                            fontSize: widget.descriptionFontSize ?? 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const CircularProgressIndicator()
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

const _defaultDecoration = BoxDecoration(
  color: Colors.white,
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.all(Radius.circular(10)),
);
