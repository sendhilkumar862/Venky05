import 'package:flutter/material.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../app_button/app_button.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class SuccessFailsInfoDialog extends StatelessWidget {
  SuccessFailsInfoDialog(
      {this.content, this.title, this.buttonTitle, super.key});

  String? content;
  String? title;
  String? buttonTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              title ?? ''!,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(
              height: 12,
            ),
            const AppImageAsset(
              image: ImageConstants.successCircle,
              height: 63,
            ),
            const SizedBox(
              height: 12,
            ),
            AppText(
              content ?? ''!,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              borderColor: AppColors.appBlue,
              height: 40,
              title: buttonTitle!,
              borderRadius: BorderRadius.circular(10),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            )
          ],
        ),
      ),
    );
  }
}
