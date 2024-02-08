import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../../product/utils/typography.dart';
import '../app_button/app_button.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class WarningDialog extends StatelessWidget {
  Function()? onTap;
   WarningDialog({
    super.key,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(top: 14.px),
              alignment: Alignment.center,
              height: 25.px,
              width: 25.px,
              decoration: const BoxDecoration(
                  color: AppColors.appLightGrey, shape: BoxShape.circle),
              child: AppImageAsset(
                image: ImageConstants.closeIcon,
                height: 20.px,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20.px,
              ),
              AppImageAsset(image: ImageConstants.warningCircle, height: 40.px),
              SizedBox(height: 15.px),
              const AppText(
                'Cancel Booking Confirmation',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 12.px),
              AppText(
                'Are you sure you want to cancel the class booking?',
                fontSize: 12.px,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 18.px),
              AppButton(
                title: 'No, Keep It',
                isDisable: false,
                borderColor: AppColors.appBlue,
                height: 45.px,
                onPressed: ()=>Get.back(),
              ),
              SizedBox(height: 22.px),
              GestureDetector(
                onTap: onTap!,
                child: AppText(
                  'Yes, Cancel the Booking',
                  fontSize: 14.px,
                  fontWeight: FontWeight.w600,
                  color: AppColors.appLightRed,
                ),
              ),
              SizedBox(height: 24.px),
            ],
          ),
        ],
      ),
    );
  }
}
