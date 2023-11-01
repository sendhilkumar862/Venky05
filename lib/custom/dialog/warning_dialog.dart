import 'package:flutter/material.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../app_button/app_button.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class WarningDialog extends StatelessWidget {
  const WarningDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 14),
              alignment: Alignment.center,
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                  color: AppColors.appLightGrey,
                  shape: BoxShape.circle),
              child: const AppImageAsset(
                image: ImageConstants.closeIcon,
                height: 20,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const AppImageAsset(
                  image: ImageConstants.warningCircle,
                  height: 40),
              const SizedBox(height: 15),
              const AppText(
                'Cancel Booking Confirmation',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 12),
              const AppText(
                'Are you sure you want to cancel the class booking?',
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 18),
              AppButton(
                title: 'No, Keep It',
                borderColor: AppColors.appBlue,
                height: 45,
                onPressed: () {},
              ),
              const SizedBox(height: 22),
              const AppText(
                'Yes, Cancel the Booking',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.appLightRed,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ],
      ),
    );
  }
}
