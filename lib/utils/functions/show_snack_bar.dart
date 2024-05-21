import "package:flutter/material.dart";
import "package:mrwebbeast/utils/functions/app_functions.dart";
import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";


void showSnackBar({
  required String text,
  Color? color,
  Color? textColor,
  IconData? icon,
  Duration? duration,
  bool? error,
}) {
  BuildContext? context = getContext();

  if (context != null) {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(10),
        shape: const StadiumBorder(),
        duration: duration ?? const Duration(milliseconds: 3000),
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(color: textColor ?? Colors.white),
            ),
            Icon(
              icon ?? (error == true ? Icons.error_outline : Icons.check_circle_rounded),
              color: Colors.white,
            ),
          ],
        ),
        backgroundColor: color ?? (error == true ? Colors.red : context.colorScheme.primary),
      ),
    );
  }
}
