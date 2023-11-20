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
  AppBarOnBoard({
    this.title,
    this.icon,
    this.onTap,
    super.key,
    this.backNavigate,
  }) : super(
          child: Container(),
          preferredSize: const Size.fromHeight(60),
        );

  String? title;
  String? icon;
  VoidCallback? onTap;
  bool? backNavigate;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appWhite,
      elevation: 0,
      leading: backNavigate ?? true
          ? GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.keyboard_backspace,
                color: AppColors.appDarkBlack,
              ),
            )
          : const SizedBox(),
      actions: <Widget>[
        Align(
          child: Row(
            children: <Widget>[
              AppText(
                title ?? 'about'.tr(),
                color: AppColors.appBlue,
                fontSize: 14.px,
              ),
              SizedBox(width: 6.px),
              InkWell(
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
                child: AppImageAsset(
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
