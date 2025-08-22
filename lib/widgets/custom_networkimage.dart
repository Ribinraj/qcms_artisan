import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';

class ImageWithFallback extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final bool showBorder; // 👈 new flag

  const ImageWithFallback({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 12,
    this.showBorder = true, // 👈 default true
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? ResponsiveUtils.wp(20),
      height: height ?? ResponsiveUtils.hp(10),
      decoration: BoxDecoration(
        color: Appcolors.kbackgroundcolor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: showBorder
            ? Border.all(
                color: Appcolors.ksecondaryColor.withAlpha(77),
                width: 1.5,
              )
            : null, // 👈 conditional border
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius - 1),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit,
          placeholder: (context, url) => Container(
            decoration: BoxDecoration(
              color: Appcolors.ksecondaryColor.withAlpha(33),
            ),
            child: Center(
              child: SpinKitCircle(
                color: Appcolors.ksecondaryColor,
                size: 20,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              color: Appcolors.ksecondaryColor.withAlpha(33),
            ),
            child: Icon(
              Icons.image_not_supported_rounded,
              color: Appcolors.kTertiaryColor.withAlpha(200),
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
