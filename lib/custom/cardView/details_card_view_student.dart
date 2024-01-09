import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class DetailsCardViewStudent extends StatelessWidget {
  DetailsCardViewStudent({
    this.countryName,
    this.name,
    this.avatar,

    this.grades,
    this.isBookmarked,
    this.cardMargin,
    this.boxShadow,
    super.key,
  });


  String? avatar;
  String? name;

  bool? isBookmarked;

  String? countryName;
  String? grades;
  EdgeInsetsGeometry? cardMargin;
  List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(10.px),
      margin:
      cardMargin ?? EdgeInsets.only(left: 15.px, top: 10.px, bottom: 27.px),
      width: 140.px,
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(13.px),
        border: Border.all(
          color: AppColors.appBorderColor.withOpacity(0.3),
          width: 1.2,
        ),
        boxShadow: boxShadow ?? AppColors.infoBoxShadow,
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16.px),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AppImageAsset(
                  image: ImageConstants.teacherAvtar,
                  height: 50.px,
                ),
                AppText(name ?? ''),
                AppText(
                  grades ?? '',
                  fontSize: 10.px,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: AppImageAsset(
              image: (isBookmarked ?? false)
                  ? ImageConstants.removeBookmark
                  : ImageConstants.doBookmark,
              height: 18.px,
            ),
          ),
        ],
      ),
    );
  }
}
