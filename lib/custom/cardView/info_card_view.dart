import 'package:flutter/material.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../app_button/app_button.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';
import 'heading_card_view.dart';

class InfoCardVIew extends StatelessWidget {
  InfoCardVIew({
    this.heading,
    this.isShowButton,
    this.title,
    this.subTitle,
    this.cardColor,
    this.isViewAllIcon,
    this.viewAllOnTap,
    this.buttonTap,
    super.key,
  });

  String? heading;
  String? title;
  String? subTitle;
  bool? isShowButton;
  bool? isViewAllIcon;
  Color? cardColor;
  VoidCallback? viewAllOnTap;
  VoidCallback? buttonTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HeadingCardView(
            title: heading, isViewAllIcon: isViewAllIcon, onTap: viewAllOnTap),
        const SizedBox(height: 15),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: cardColor ?? AppColors.appWhite,
            border: Border.all(color: AppColors.lightPurple, width: 1.7),
          ),
          child: Column(
            children: <Widget>[
              const AppImageAsset(
                image: ImageConstants.starSecondary,
                height: 55,
              ),
              const SizedBox(height: 13),
              AppText(
                title!,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 5),
              AppText(subTitle!,
                  textAlign: TextAlign.center,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appLightBlack),
              if (isShowButton!) const SizedBox(height: 13),
              if (isShowButton!)
                AppButton(
                  height: 42,
                  title: 'Create New Class',
                  textStyle: const TextStyle(
                      color: AppColors.appBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  borderRadius: BorderRadius.circular(12),
                  borderColor: AppColors.appBlue,
                  isBorderOnly: true,
                  onPressed: buttonTap!,
                )
            ],
          ),
        ),
      ],
    );
  }
}
