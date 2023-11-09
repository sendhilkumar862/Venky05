import 'package:flutter/material.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/utils/typography.dart';


class AppText extends StatelessWidget {

  const AppText(
    this.title, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontFamily, // = AppAsset.defaultFont,
    this.fontSize,
    this.textAlign,
    this.height,
    this.fontStyle,
    this.maxLines,
    this.overflow,
    this.decoration = TextDecoration.none,
    this.letterSpacing,
  });

  final String title;
  final Color? color;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? fontSize;
  final TextAlign? textAlign;
  final double? height;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        color: color ?? AppColors.appDarkBlack,
        fontFamily:  fontFamily??TextFontFamily.openSans,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: fontSize ?? 16,
        height: height,
        fontStyle: fontStyle,
        overflow: overflow,
        decoration: decoration,
        decorationColor: AppColors.appGrey.withOpacity(0.5),
        letterSpacing: letterSpacing,
      ),
    );
  }
}
