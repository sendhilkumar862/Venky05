import 'package:flutter/material.dart';
import 'package:hessah/custom/cardView/status_card_view.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../../product/utils/typography.dart';
import '../app_button/app_button.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class InfoCardVIew extends StatelessWidget {
  InfoCardVIew({
    this.isShowButton,
    this.title,
    this.message,
    this.subTitle,
    this.cardColor,
    this.buttonTap,
    this.buttonTitle,
    this.isPending,
    this.isStatus,
    this.isStatusRejected,
    this.isStatusSusPended,
    this.isStatusAction,
    this.isSupport,
    super.key,
  });

  String? title;
  String? subTitle;
  String? message;
  bool? isShowButton;
  Color? cardColor;
  String? buttonTitle;
  bool? isStatus = false;
  bool? isStatusRejected = false;
  bool? isStatusSusPended = false;
  bool? isStatusAction = false;
  VoidCallback? buttonTap;
  bool? isPending = false;
  bool? isSupport = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      padding: EdgeInsets.all(12.px),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.px),
        color: cardColor ?? AppColors.appWhite,
        border: Border.all(color: AppColors.lightPurple, width: 1.7.px),
      ),
      child: Column(
        children: <Widget>[
          Lottie.asset(ImageConstants.completeProfile,
              height: 55.px),
          if (isStatus ?? false)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: StatusCardView(status: 'PENDING ACCOUNT'),
            ),
          if (isStatusRejected ?? false)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: StatusCardView(status: 'REJECTED'),
            ),
          if (isStatusSusPended ?? false)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: StatusCardView(status: 'SUSPENDED'),
            ),
          if (isStatusAction ?? false)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: StatusCardView(status: 'ACTION NEEDED'),
            ),
          SizedBox(height: 13.px),
          AppText(
            title ?? '',
            fontSize: 16.px,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 2.px),
          if (message != null)
            AppText(
              message ?? '',
              fontSize: 12.px,
              color: AppColors.appDarkBlack.withOpacity(0.25),
              fontWeight: FontWeight.w400,
            ),
          if (message != null) SizedBox(height: 5.px),
          AppText(subTitle ?? '',
              textAlign: TextAlign.center,
              fontSize: 14.px,
              fontWeight: FontWeight.w400,
              color: AppColors.appLightBlack),
          // ignore: use_if_null_to_convert_nulls_to_bools
          if (isSupport == true) SizedBox(height: 13.px),
          // ignore: use_if_null_to_convert_nulls_to_bools
          if (isSupport == true)
            RichText(
              text: TextSpan(
                text: 'Contact us at ',
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: 'support@hessah.app',
                      style: openSans.get12.w400.appBlue.underline),
                ],
              ),
            ),
          if (isShowButton ?? true) SizedBox(height: 13.px),
          if (isShowButton ?? true)
            AppButton(
              isDisable: true,
              height: 42.px,
              title: buttonTitle ?? '',
              textStyle: TextStyle(
                  color: AppColors.appBlue,
                  fontSize: 14.px,
                  fontWeight: FontWeight.w600),
              borderRadius: BorderRadius.circular(12.px),
              borderColor: AppColors.appBlue,
              isBorderOnly: true,
              onPressed: buttonTap ?? () {},
            ),
        ],
      ),
    );
  }
}
