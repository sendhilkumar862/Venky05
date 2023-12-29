
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/countdown_timer/timer_controller.dart';
import '../../../../custom/countdown_timer/timer_count_down.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/otp/otp_text_field.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../controller/mobile_otp_controller.dart';



class MobileOtpView extends StatelessWidget {
   MobileOtpView({super.key});
  final MobileOTPController _mobileOTPController=Get.put(MobileOTPController());
  @override
  Widget build(BuildContext context) {
    return Obx( () {
      return Scaffold(
        body: PreLoginCustomBody(
          widget: Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 15.px),
              children: <Widget>[
                SizedBox(height: 10.px),
                SafeArea(bottom: false, child: OnTapBack()),
                SizedBox(height: 40.px),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    textAlign: TextAlign.start,
                    'verifyMobileNumber'.tr,
                    fontSize: 24.px,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 15.px),
                AppText(
                  textAlign: TextAlign.start,
                  'enterTheCodeWe'.tr,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 20.px),
                OtpTextField(
                  fieldWidth: 73.px,
                  borderRadius: BorderRadius.circular(8.px),
                  //  numberOfFields: numberOfFields,
                  borderColor: AppColors.appGrey,

                  enabledBorderColor: (_mobileOTPController.isCorrect.value)
                      ? AppColors.appLightGrey
                      : AppColors.appRed,
                  //   focusedBorderColor: primaryColor,
                  // clearText: clearText,
                  showFieldAsBox: true,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16.px),
                  onCodeChanged: (String value) {},
                  handleControllers:
                      (List<TextEditingController?> controllers) {
                    //emailOtpViewModel.enteredOTP = controllers.toString();
                  },
                  //clearText: !emailOtpViewModel.isCorrect,
                  onSubmit: (String verificationCode) {
                    _mobileOTPController.enteredOTP.value = verificationCode;
                  }, // end onSubmit
                ),
                SizedBox(height: 10.px),
                if (!_mobileOTPController.isCorrect.value)
                  AppText(
                    'otpIncorrect'.tr,
                    fontSize: 12.px,
                    fontWeight: FontWeight.w400,
                    color: AppColors.appRed,
                  ),
                SizedBox(
                  height: 20.px,
                ),
                AppText(
                  'didntReceived'.tr,
                  fontSize: 12.px,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appGrey,
                ),
                SizedBox(height: 12.px),
                Countdown(
                  controller: _mobileOTPController.controller,
                  seconds: 30,
                  build: (_, double time) => AppText(
                    AppUtils.formatTimer(time.toInt()),
                    color: AppColors.appPurple,
                    fontWeight: FontWeight.w700,
                    fontSize: 24.px,
                    textAlign: TextAlign.center,
                  ),
                  onFinished: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Timer is done!'),
                      ),
                    );
                  },
                ),
                SizedBox(height: 12.px),
                GestureDetector(
                  onTap: () => CountdownController(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppImageAsset(
                        image: ImageConstants.arrowRotate,
                        height: 20.px,
                      ),
                      SizedBox(width: 5.px),
                      AppText(
                        'sendAgain'.tr,
                        fontSize: 13.px,
                        fontWeight: FontWeight.w600,
                        color: AppColors.appBlue,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: PreLoginCommonButton(
          title: 'continue'.tr,
          onTap: () => _mobileOTPController.verifyOtp(),
          isDisable: _mobileOTPController.enteredOTP.value.length != 4,
        ),
      );
    });
  }
}
