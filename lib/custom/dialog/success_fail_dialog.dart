import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../config/routes/route.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../app_button/app_button.dart';
import '../divider/divider.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

// ignore: must_be_immutable
class SuccessFailsInfoDialog extends StatelessWidget {
  SuccessFailsInfoDialog(
      {this.content,
      this.title,
      this.buttonTitle,
      this.tranId,
        this.isRouting='',
      this.verticalPadding,
      super.key});

  String? content;
  String? title;
  String? buttonTitle;
  String? tranId;
  String? isRouting;
  double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: verticalPadding ?? 25, horizontal: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppText(
            title ?? '',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(
            height: 12,
          ),
          if (title == 'Success')
            const AppImageAsset(
              image: ImageConstants.successCircle,
              height: 63,
            )
          else
            const AppImageAsset(
              image: ImageConstants.failCircle,
              height: 63,
            ),
          const SizedBox(
            height: 12,
          ),
          AppText(
            content ?? '',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
          if (tranId != null && tranId!.isNotEmpty)
            Column(
              children: <Widget>[
                SizedBox(
                  height: 5.px,
                ),
                AppDivider(),
                SizedBox(
                  height: 5.px,
                ),
                AppText(
                  'Transaction Number',
                  fontSize: 12.px,
                  color: AppColors.appGrey,
                ),
                SizedBox(
                  height: 3.px,
                ),
                AppText(tranId ?? ''),
              ],
            ),
          const SizedBox(
            height: 20,
          ),
          AppButton(
            isDisable: false,
            borderColor: AppColors.appBlue,
            height: 40,
            title: buttonTitle!,
            borderRadius: BorderRadius.circular(10),
            onPressed: () {
              Navigator.of(context).pop();
              if(isRouting=='back'){
                Navigator.of(context).pop();
               }else if(isRouting=='route'){
                Get.offAndToNamed(Routes.settingView );
              }
              else if(isRouting!=''){
                Get.offAndToNamed(isRouting! );
              }
            },
          )
        ],
      ),
    );
  }
}
