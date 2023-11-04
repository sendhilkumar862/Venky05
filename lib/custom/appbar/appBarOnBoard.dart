import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class AppBarOnBoard extends PreferredSize {
   AppBarOnBoard({super.key}): super(
     child: Container(),
     preferredSize: const Size.fromHeight(60),
   );

  @override
  Widget build(BuildContext context) {
    return  AppBar(
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
              const AppText(
                'About Hessah',
                color: AppColors.appBlue,
              ),
              SizedBox(width: 6.px),
              AppImageAsset(
                image: ImageConstants.infoRoundCircle,
                height: 20.px,
                color: AppColors.appBlue,
              ),
              SizedBox(width: 10.px),
            ],
          ),
        )
      ],
    );
  }
}
