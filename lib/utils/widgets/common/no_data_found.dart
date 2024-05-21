import "package:flutter/material.dart";
import "package:mrwebbeast/core/config/app_assets.dart";
import "package:mrwebbeast/utils/theme/colors.dart";
import "package:mrwebbeast/utils/widgets/image/image_view.dart";

class NoDataFound extends StatefulWidget {
  const NoDataFound({super.key, this.message, this.heightFactor, this.widthFactor, this.title, this.onTap});

  final String? title;
  final String? message;
  final double? heightFactor;
  final double? widthFactor;
  final GestureTapCallback? onTap;

  @override
  State<NoDataFound> createState() => _NoDataFoundState();
}

class _NoDataFoundState extends State<NoDataFound> {
  late String? title = widget.title;
  late String? message = widget.message;
  late double? heightFactor = widget.heightFactor;
  late double? widthFactor = widget.widthFactor;
  late GestureTapCallback? onTap = widget.onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: heightFactor != null ? size.height * heightFactor! : null,
      width: widthFactor != null ? size.width * widthFactor! : size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageView(
              width: 200,
              assetImage: AppAssets.noImage,
              margin: const EdgeInsets.only(bottom: 24),
              onTap: onTap,
            ),
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  title ?? "Not Found",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            Text(
              message ?? "No Data Found",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
