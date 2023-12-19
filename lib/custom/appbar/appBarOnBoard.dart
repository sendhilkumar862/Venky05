
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../feature/tutorial/view/bottomSheets/about_app_bottom_view.dart';
import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class AppBarOnBoard extends PreferredSize {
  AppBarOnBoard({
    this.title,
    this.icon,
    this.onTap,
    this.onBackTap,
    super.key,
    this.backNavigate,
  }) : super(
          child: Container(),
          preferredSize: const Size.fromHeight(60),
        );

  String? title;
  String? icon;
  VoidCallback? onTap;
  VoidCallback? onBackTap;
  bool? backNavigate;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appWhite,
      elevation: 0,
      leading: backNavigate ?? true
          ? GestureDetector(
              onTap: onBackTap,
              child: const Icon(
                Icons.keyboard_backspace,
                color: AppColors.appDarkBlack,
              ),
            )
          : const SizedBox(),
      actions: <Widget>[
        Align(
          child: InkWell(
            onTap: onTap ??
                () {
                  showModalBottomSheet(
                    context: context,
                    constraints: const BoxConstraints(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.px),
                        topLeft: Radius.circular(25.px),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return AboutAppBottomSheet();
                    },
                  );
                },
            child: Row(
              children: [
                AppText(
                  title ?? 'about'.tr,
                  color: AppColors.appBlue,
                  fontSize: 14.px,
                ),
                SizedBox(width: 6.px),
                AppImageAsset(
                  image: icon ?? ImageConstants.infoRoundCircle,
                  height: 18.px,
                  color: AppColors.appBlue,
                ),
                SizedBox(width: 10.px),
              ],
            ),
          ),
        )
      ],
    );
  }
}
