import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../app_button/app_button.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class InfoCardViewHorizontal extends StatelessWidget {
  InfoCardViewHorizontal({
    this.heading,
    this.isShowButton,
    this.title,
    this.cardColor,
    this.isViewAllIcon,
    this.viewAllOnTap,
    this.buttonTap,
    super.key,
  });

  String? heading;
  String? title;
  bool? isShowButton;
  bool? isViewAllIcon;
  Color? cardColor;
  VoidCallback? viewAllOnTap;
  VoidCallback? buttonTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        viewAllCardView(
          heading ?? '',
          isViewAllIcon: isViewAllIcon ?? false,
          onTap: viewAllOnTap,
        ),
        SizedBox(height: 15.px),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16.px),
          padding: EdgeInsets.all(12.px),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.px),
            color: cardColor ?? AppColors.appWhite,
            border: Border.all(color: AppColors.lightPurple, width: 1.7.px),
          ),
          child: Row(
            children: <Widget>[
              AppImageAsset(
                image: ImageConstants.starSecondary,
                height: 55.px,
              ),
              SizedBox(
                width: 15.px,
              ),
              SizedBox(
                width: 230.px,
                child: Column(
                  children: [
                    SizedBox(height: 13.px),
                    AppText(
                      title!,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      fontSize: 14.px,
                      fontWeight: FontWeight.w500,
                    ),
                    if (isShowButton!) SizedBox(height: 13.px),
                    if (isShowButton!)
                      AppButton(
                        height: 37.px,
                        title: 'Create New Class',
                        textStyle: TextStyle(
                          color: AppColors.appBlue,
                          fontSize: 14.px,
                          fontWeight: FontWeight.w600,
                        ),
                        borderRadius: BorderRadius.circular(12.px),
                        borderColor: AppColors.appBlue,
                        isBorderOnly: true,
                        onPressed: buttonTap!,
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget viewAllCardView(String title, {bool? isViewAllIcon, VoidCallback? onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AppText(
            title,
            fontWeight: FontWeight.w700,
          ),
          if (isViewAllIcon!)
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: onTap,
                  child: AppText(
                    'View All',
                    color: AppColors.appBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.px,
                  ),
                ),
                SizedBox(
                  width: 10.px,
                ),
                AppImageAsset(
                  image: ImageConstants.layersIcon,
                  height: 18.px,
                ),
              ],
            )
        ],
      ),
    );
  }
}
