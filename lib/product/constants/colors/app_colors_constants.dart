import 'package:flutter/material.dart';
import '../../extension/colors_extension.dart';

class AppColors {

  static  Color primaryColor = HexColor('#002BC7');
  static const Color secondaryColor = Color(0xFFEF6F6C);
  static const Color accentColor = Color(0xFFFFD700);
  static const Color appYellow = Color(0xFFFFD600);
  static const Color appTransparent = Color(0x00000000);
  static const Color appWhite = Color(0xffFFFFFF);
  static const Color appLightBlack = Color(0xFF5E5F60);
  static const Color appGrey = Color(0xFFa1a3a6);
  static const Color appRed = Color(0xFFf26c61);
  static const Color appLightGreen = Color(0xFF69c9cd);
  static const Color appBlue = Color(0xFF002BC7);
  static const Color appDarkBlack = Color(0xFF051335);
  static const Color appDarkGrey = Color(0xFF515151);
  static const Color appLightGrey = Color(0xFFeeeeee);
  static const Color appErrorColor = Color(0xFFd92d20);
  static const Color appBrown = Color(0xFF856404);
  static const Color appPurple = Color(0xFF9185FF);
  static const Color lightPurple= Color(0xffE9EEFF);
  static const Color appGreen= Color(0xff07B53B);
  static const Color appLightRed= Color(0xffFF4956);
  static const Color appOrange= Color(0xffF28602);
  static const Color appLightBlue= Color(0xff3D67FF);

  static const Color trans = Colors.transparent;
  static const Color black = Colors.black;
  static const Color red = Colors.red;
  static const Color gray = Colors.grey;
  static const Color white = Colors.white;
  static const Color appColor = Color(0xff002BC7);
  static const Color appBorderColor = Color(0xffC5CEEE);
  static const Color darkPurple= Color(0xff05133580);
  static const Color appShadow= Color(0xffdddddd);

  static List<BoxShadow> appBoxShadow = [
    BoxShadow(
      offset: const Offset(1, 3),
      spreadRadius: 5,
      color: appLightBlack.withOpacity(0.2),
      blurRadius: 10,
    ),
  ];

  static List<BoxShadow> infoBoxShadow = [
     BoxShadow(
      offset: const Offset(1, 6),
      color: appShadow.withOpacity(0.5),
      blurRadius: 5,
    ),
  ];

  static List<BoxShadow> appCardShadow = [
    const BoxShadow(
        color: AppColors.appShadow,
        offset: Offset(-1, 8),
        blurRadius: 15,
    spreadRadius: -4),
  ];

  static List<BoxShadow> appDarkBoxShadow = [
    BoxShadow(
      offset: const Offset(0, 3),
      spreadRadius: 0.2,
      color: appWhite.withOpacity(0.2),
      blurRadius: 2,
    ),
  ];

  static const Color textWhite80Color = Color(0xFFf2f2f2);
}
