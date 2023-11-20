import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../feature/tutorial/view/bottomSheets/about_app_bottom_view.dart';
import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../image/app_image_assets.dart';
import '../sheet/show_bottom_sheet.dart';
import '../text/app_text.dart';

class AppBarOnBoard extends PreferredSize {
  AppBarOnBoard({this.title, this.icon, this.onTap, super.key})
      : super(
          child: Container(),
          preferredSize: const Size.fromHeight(60),
        );

  String? title;
  String? icon;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appWhite,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.keyboard_backspace,
          color: AppColors.appDarkBlack,
        ),
      ),
      actions: [
        Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              AppText(
                title ?? 'about'.tr(),
                color: AppColors.appBlue,
                fontSize: 14.px,
              ),
              SizedBox(width: 6.px),
              InkWell(
                onTap: onTap ?? () {},
                child: AppImageAsset(
                  image: icon ?? ImageConstants.infoRoundCircle,
                  height: 18.px,
                  color: AppColors.appBlue,
                ),
              ),
              SizedBox(width: 10.px),
            ],
          ),
        )
      ],
    );
  }
}
