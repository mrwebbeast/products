import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mrwebbeast/app.dart";
import "package:mrwebbeast/core/config/app_config.dart";
import "package:mrwebbeast/utils/theme/colors.dart";

///1) App Context...
BuildContext? getContext() => MyApp.navigatorKey.currentContext;

///2) App Link...
String apkLink() {
  String url;

  if (defaultTargetPlatform == TargetPlatform.iOS) {
    url = AppConfig.appStoreUrl;
  } else {
    url = AppConfig.playStoreUrl;
  }

  return url;
}

///3) show Confirmation Dialog...
Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String description,
  Color? color,
  required TextButton proceedButton,
  TextButton? cancelButton,
}) async {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: TextStyle(
            color: color ?? Colors.black,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          cancelButton ??
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
          proceedButton,
        ],
        content: Text(
          description,
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}
