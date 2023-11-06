import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class WarningCardView extends StatelessWidget {
  WarningCardView({
    this.error,
    this.color,
    super.key,
  });

  String? error;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.px),
      decoration: BoxDecoration(
        color: color ?? AppColors.lightPurple,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          width: 10.px,
        ),
        AppImageAsset(
          image: ImageConstants.reschedulingStatus,
          color: AppColors.appDarkBlack,
          height: 20.px,
        ),
        SizedBox(
          width: 10.px,
        ),
        AppText(
          error ?? '',
          fontSize: 12.px,
          fontWeight: FontWeight.w400,
        )
      ]),
    );
  }
}
