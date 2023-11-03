import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../app_button/app_button.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';
import 'heading_card_view.dart';

class InfoCardVIew extends StatelessWidget {
  InfoCardVIew({
    this.isShowButton,
    this.title,
    this.subTitle,
    this.cardColor,
    this.buttonTap,
    this.buttonTitle,
    super.key,
  });

  String? title;
  String? subTitle;
  bool? isShowButton;
  Color? cardColor;
  String? buttonTitle;
  VoidCallback? buttonTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      padding: EdgeInsets.all(12.px),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.px),
        color: cardColor ?? AppColors.appWhite,
        border: Border.all(color: AppColors.lightPurple, width: 1.7.px),
      ),
      child: Column(
        children: <Widget>[
          AppImageAsset(
            image: ImageConstants.starSecondary,
            height: 55.px,
          ),
          SizedBox(height: 13.px),
          AppText(
            title??'',
            fontSize: 16.px,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 5.px),
          AppText(subTitle??'',
              textAlign: TextAlign.center,
              fontSize: 14.px,
              fontWeight: FontWeight.w400,
              color: AppColors.appLightBlack),
          if (isShowButton??true) SizedBox(height: 13.px),
          if (isShowButton??true)
            AppButton(isDisable: true,
              height: 42.px,
              title: buttonTitle??'',
              textStyle: TextStyle(
                  color: AppColors.appBlue,
                  fontSize: 14.px,
                  fontWeight: FontWeight.w600),
              borderRadius: BorderRadius.circular(12.px),
              borderColor: AppColors.appBlue,
              isBorderOnly: true,
              onPressed: buttonTap!,
            )
        ],
      ),
    );
  }
}
