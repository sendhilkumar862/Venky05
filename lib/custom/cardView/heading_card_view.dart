import 'package:flutter/material.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class HeadingCardView extends StatelessWidget {
  HeadingCardView({
    this.isViewAllIcon = false,
    this.title,
    this.onTap,
    this.totalItem,
    this.padding,
    super.key,
  });

  VoidCallback? onTap;
  bool? isViewAllIcon;
  String? totalItem;
  String? title;
  double? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              AppText(
                title ?? ''!,
                fontWeight: FontWeight.w700,
              ),
              if (totalItem != null && totalItem!.isNotEmpty)
                AppText(
                  ' ($totalItem)',
                  fontWeight: FontWeight.w700,
                  color: AppColors.appGrey,
                ),
            ],
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
