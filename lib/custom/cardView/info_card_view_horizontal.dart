import 'package:flutter/material.dart';

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
        viewAllCardView(heading ?? ''!,
            isViewAllIcon: isViewAllIcon ?? false, onTap: viewAllOnTap),
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
          child: Row(
            children: <Widget>[
              const AppImageAsset(
                image: ImageConstants.starSecondary,
                height: 55,
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 230,
                child: Column(
                  children: [
                    const SizedBox(height: 13),
                    AppText(
                      title!,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    if (isShowButton!) const SizedBox(height: 13),
                    if (isShowButton!)
                      AppButton(
                        height: 37,
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
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget viewAllCardView(String title,
      {bool? isViewAllIcon, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  child: const AppText(
                    'View All',
                    color: AppColors.appBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const AppImageAsset(
                  image: ImageConstants.layersIcon,
                  height: 18,
                ),
              ],
            )
        ],
      ),
    );
  }
}
