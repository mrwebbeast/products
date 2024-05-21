import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "package:mrwebbeast/utils/theme/colors.dart";

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.height,
    this.width,
    this.constraints,
    this.validator,
    this.onChanged,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.limit,
    this.margin,
    this.obscureText,
    this.initialValue,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlignVertical,
    this.showCursor,
    this.smartDashesType,
    this.smartQuotesType,
    this.maxLengthEnforcement,
    this.minLines,
    this.maxLength,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.inputFormatters,
    this.enabled,
    this.autofocus,
    this.textAlign,
    this.readOnly,
    this.obscuringCharacter,
    this.autocorrect,
    this.cursorRadius,
    this.cursorHeight,
    this.maxLines,
    this.scrollPadding,
    this.enableIMEPersonalizedLearning,
    this.cursorColor,
    this.keyboardAppearance,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.autoValidateMode,
    this.scrollController,
    this.restorationId,
    this.fillColor,
    this.filled,
    this.mouseCursor,
    this.contentPadding,
    this.isCollapsed,
    this.floatingLabelHeight,
    this.floatingLabelProgress,
    this.floatingLabelAlignment,
    this.border,
    this.alignLabelWithHint,
    this.isDense,
    this.visualDensity,
    this.icon,
    this.input,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.helperError,
    this.counter,
    this.container,
    this.expands,
    this.borderColor,
    this.borderRadius,
    this.errorStyle,
    this.errorText,
    this.errorMaxLines,
    this.labelStyle,
    this.onTapOutside,
  });

  final TextEditingController? controller;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? borderColor;
  final BoxConstraints? constraints;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final String? labelText;
  final String? errorText;
  final int? limit;
  final int? errorMaxLines;
  final EdgeInsets? margin;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization = TextCapitalization.none;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool? autofocus;
  final bool? readOnly;
  final bool? showCursor;
  final String? obscuringCharacter;
  final bool? obscureText;
  final bool? autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions = true;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final bool? expands;
  final int? maxLength;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final TapRegionCallback? onTapOutside;

  final FormFieldSetter<String>? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double? cursorWidth = 2.0;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets? scrollPadding;
  final bool? enableInteractiveSelection;

  final TextSelectionControls? selectionControls;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autoValidateMode;
  final ScrollController? scrollController;
  final String? restorationId;
  final Color? fillColor;
  final bool? filled;
  final bool? enableIMEPersonalizedLearning;
  final MouseCursor? mouseCursor;

  //Input Decoration

  final EdgeInsetsGeometry? contentPadding;
  final bool? isCollapsed;
  final double? floatingLabelHeight;
  final double? floatingLabelProgress;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final InputBorder? border;
  final bool? alignLabelWithHint;
  final bool? isDense;
  final VisualDensity? visualDensity;
  final Widget? icon;
  final Widget? input;
  final Widget? label;
  final Widget? hint;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? helperError;
  final Widget? counter;
  final Widget? container;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.fromLTRB(16, 8, 16, 8),
      height: height,
      width: width,
      constraints: constraints,
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              key: key,
              controller: controller,
              keyboardType: keyboardType,
              autofocus: autofocus ?? false,
              minLines: minLines ?? 1,
              maxLines: maxLines ?? 1,
              maxLength: maxLength,
              enabled: enabled,
              onTap: onTap,
              obscureText: obscureText ?? false,
              inputFormatters: inputFormatters ?? [LengthLimitingTextInputFormatter(limit)],
              validator: validator,
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
              onFieldSubmitted: onFieldSubmitted,
              enableSuggestions: enableSuggestions,
              enableInteractiveSelection: enableInteractiveSelection,
              onTapOutside: onTapOutside ??
                  (val) {
                    FocusScope.of(context).unfocus();
                  },
              focusNode: focusNode,
              keyboardAppearance: keyboardAppearance,
              maxLengthEnforcement: maxLengthEnforcement,
              mouseCursor: mouseCursor,
              readOnly: readOnly ?? false,
              restorationId: restorationId,
              scrollController: scrollController,
              scrollPhysics: scrollPhysics,
              selectionControls: selectionControls,
              showCursor: showCursor,
              smartDashesType: smartDashesType,
              smartQuotesType: smartQuotesType,
              strutStyle: strutStyle,
              onSaved: onSaved,
              cursorColor: cursorColor,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              cursorWidth: cursorWidth ?? 2.0,
              textAlign: textAlign ?? TextAlign.start,
              textDirection: textDirection,
              textCapitalization: textCapitalization,
              textInputAction: textInputAction,
              autocorrect: autocorrect ?? true,
              obscuringCharacter: obscuringCharacter ?? "•",
              autofillHints: autofillHints,
              autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
              scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
              expands: expands ?? false,
              style: style ??
                  TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                    fontSize: 16,
                  ),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: hintText,
                errorText: errorText,
                errorMaxLines: errorMaxLines,
                errorStyle: errorStyle ?? const TextStyle(color: Colors.red),
                helperStyle: hintStyle,
                labelText: labelText,
                fillColor: fillColor,
                filled: filled ?? true,
                labelStyle: labelStyle ??
                    const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                hintStyle: hintStyle ??
                    const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                isDense: isDense,
                isCollapsed: isCollapsed ?? false,
                contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(16, 12, 6, 12),
                floatingLabelAlignment: floatingLabelAlignment,
                prefix: prefix,
                prefixIcon: prefixIcon,
                prefixIconColor: primaryColor,
                suffix: suffix,
                suffixIcon: suffixIcon,
                suffixIconColor: primaryColor,
                border:
                    border ?? inputBorder(color: borderColor, borderRadius: borderRadius, context: context),
                enabledBorder:
                    border ?? inputBorder(color: borderColor, borderRadius: borderRadius, context: context),
                errorBorder:
                    border ?? inputBorder(color: borderColor, borderRadius: borderRadius, context: context),
                focusedErrorBorder:
                    border ?? inputBorder(color: borderColor, borderRadius: borderRadius, context: context),
                disabledBorder:
                    border ?? inputBorder(color: borderColor, borderRadius: borderRadius, context: context),
                focusedBorder:
                    border ?? inputBorder(color: borderColor, borderRadius: borderRadius, context: context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputBorder inputBorder({Color? color, double? borderRadius, required BuildContext context}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? Colors.grey.shade300.withOpacity(0.7)),
      borderRadius: BorderRadius.circular(borderRadius ?? 12),
    );
  }
}
