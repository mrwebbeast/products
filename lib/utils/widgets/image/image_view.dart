import "dart:io";

import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:go_router/go_router.dart";
import "package:mrwebbeast/core/routes/route_configs.dart";

import "package:mrwebbeast/core/config/app_assets.dart";

import "package:mrwebbeast/utils/theme/colors.dart";

class ImageView extends StatelessWidget {
  const ImageView({
    super.key,
    this.assetImage,
    this.networkImage,
    this.height,
    this.width,
    this.borderRadiusValue,
    this.margin,
    this.errorWidget,
    this.loadingWidget,
    this.color,
    this.file,
    this.fit,
    this.onTap,
    this.border,
    this.borderRadius,
    this.backgroundColor,
    this.gradient,
    this.boxShadow,
    this.padding,
    this.isAvatar,
    this.fullScreenMode,
  });

  final String? assetImage;
  final String? networkImage;
  final File? file;
  final double? height;
  final double? width;

  final BorderRadius? borderRadius;
  final double? borderRadiusValue;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  final Color? color;
  final Color? backgroundColor;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Border? border;
  final Widget? loadingWidget;
  final GestureTapCallback? onTap;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final double defaultBorderRadius = 0;
  final bool? isAvatar;
  final bool? fullScreenMode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? ((fullScreenMode == true) ? () {} : null),
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        margin: margin ?? const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(borderRadiusValue ?? defaultBorderRadius),
          boxShadow: boxShadow,
          gradient: gradient,
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(borderRadiusValue ?? defaultBorderRadius),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: imageWidget(),
          ),
        ),
      ),
    );
  }

  Widget imageWidget() {
    if (kIsWeb == false && networkImage != null) {
      return CachedNetworkImage(
        color: color,
        height: height,
        width: width,
        fit: fit,
        imageUrl: "$networkImage",
        placeholder: (context, url) => cacheLoadingImage(context: context, url: url),
        errorWidget: (context, url, error) =>
            errorWidget ?? cacheImageError(context: context, url: url, isAvatar: isAvatar),
      );
    } else if (assetImage != null) {
      return Image.asset(
        "$assetImage",
        color: color,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ??
            imageError(context: context, error: error, stackTrace: stackTrace, isAvatar: isAvatar),
      );
    } else if (file != null) {
      return Image.file(
        file!,
        color: color,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ??
            imageError(context: context, error: error, stackTrace: stackTrace, isAvatar: isAvatar),
      );
    } else {
      return Image.network(
        "$assetImage",
        color: color,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ??
            imageError(context: context, error: error, stackTrace: stackTrace, isAvatar: isAvatar),
      );
    }
  }

  /// Cache Image Widgets...
  Widget cacheLoadingImage({
    required BuildContext context,
    required String? url,
  }) {
    return SizedBox(
      height: height ?? 10,
      width: width ?? 10,
      child: Center(
        child: CupertinoActivityIndicator(color: primaryColor),
      ),
    );
  }

  Widget cacheImageError({
    required BuildContext context,
    required String? url,
    bool? isAvatar,
  }) {
    return Image.asset(
      isAvatar == true ? AppAssets.avatarImage : AppAssets.noImage,
      color: color,
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          imageError(context: context, error: error, stackTrace: stackTrace),
    );
  }

  /// Assert Image Widgets...
  Widget loadingImage({
    required BuildContext context,
    required Widget child,
    ImageChunkEvent? loadingProgress,
  }) {
    if (loadingProgress == null) return child;

    return SizedBox(
      height: height ?? 10,
      width: width ?? 10,
      child: Center(
        child: CupertinoActivityIndicator(color: primaryColor),
      ),
    );

    // You can use LinearProgressIndicator or CupertinoActivityIndicator instead
  }

  Widget imageError({
    required BuildContext context,
    required Object error,
    bool? isAvatar,
    StackTrace? stackTrace,
  }) {
    return Image.asset(
      isAvatar == true ? AppAssets.avatarImage : AppAssets.noImage,
      color: color,
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          imageError(context: context, error: error, stackTrace: stackTrace, isAvatar: isAvatar),
    );
  }
}
