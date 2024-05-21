import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.imagePath,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    required this.onPressed,
    this.textStyle,
    this.margin,
    this.splashColor,
    this.icon,
    this.height,
    this.width,
    this.fontSize,
    this.fontWeight,
    this.imageColor,
    this.splashEffect,
    this.mainAxisAlignment,
    this.trailingImage,
    this.boxShadow,
    this.letterSpacing,
  });

  final String text;
  final String? imagePath;
  final String? trailingImage;
  final Icon? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? splashColor;
  final double? borderRadius;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final Color? imageColor;
  final bool? splashEffect;
  final List<BoxShadow>? boxShadow;

  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: splashEffect == true ? null : onPressed,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            boxShadow: boxShadow,
          ),
          child: OutlinedButton(
            style: ButtonStyle(
              overlayColor:
                  WidgetStateProperty.all(splashColor ?? context.colorScheme.primary.withOpacity(0.4)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 11),
                ),
              ),
              backgroundColor: WidgetStateProperty.all(backgroundColor ?? context.colorScheme.primary),
              side: WidgetStateProperty.all(
                BorderSide(
                  color: borderColor ?? context.colorScheme.primary,
                  width: 1.2,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            onPressed: splashEffect == true ? onPressed : null,
            child: Row(
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
              children: [
                if (imagePath != null)
                  SizedBox(
                    height: 22,
                    width: 22,
                    child: Image.asset(
                      "$imagePath",
                      color: imageColor,
                    ),
                  ),
                if (icon != null) icon!,
                Text(
                  text,
                  style: textStyle ??
                      TextStyle(
                        color: textColor ?? Colors.white,
                        fontWeight: fontWeight ?? FontWeight.w600,
                        letterSpacing: letterSpacing,
                        fontSize: fontSize ?? 14,
                      ),
                ),
                if (trailingImage != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SizedBox(
                      height: 22,
                      width: 22,
                      child: Image.asset(
                        "$trailingImage",
                        color: imageColor,
                      ),
                    ),
                  )
                else
                  const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
