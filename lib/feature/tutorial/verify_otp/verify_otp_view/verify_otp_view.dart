

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../custom/countdown_timer/timer_controller.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/otp/otp_text_field.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../controller/verify_otp_controller.dart';


class VerifyOtpView extends StatelessWidget {
   VerifyOtpView({super.key});
  final RegExp _emailMaskRegExp = RegExp('^(.)(.*?)([^@]?)(?=@[^@]+\$)');

  String maskEmail(String input, [int minFill = 4, String fillChar = '*']) {
    minFill ??= 4;
    fillChar ??= '*';
    return input.replaceFirstMapped(_emailMaskRegExp, (m) {
      var start = m.group(1);
      var middle = fillChar * max(minFill, m.group(2)!.length);
      var end = m.groupCount >= 3 ? m.group(3) : start;
      return start! + middle + end!;
    });
  }
   final VerifyOtpController _verifyOtpController=Get.put(VerifyOtpController());
  @override
  Widget build(BuildContext context) {
    _verifyOtpController.arguments = ModalRoute.of(context)!
        .settings
        .arguments! as Map<String, dynamic>;
    _verifyOtpController.otpId.value =
        _verifyOtpController.arguments['otp_id'].toString();
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
                SizedBox(height: 180.px),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    textAlign: TextAlign.start,
                    (_verifyOtpController.arguments['isScreen'])
                        ? 'verifyEmailAddress'.tr
                        : 'verifyMobileNumber'.tr,
                    fontSize: 24.px,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 15.px),
                AppText(
                  textAlign: TextAlign.start,
                  (_verifyOtpController.arguments['isScreen'])
                      ? 'enterTheVerification'.tr+ maskEmail(_verifyOtpController.arguments['email'].toString())
                      : 'enterTheCodeWe'.tr+_verifyOtpController.arguments['mobile'].toString().substring(0,2)+'XXXXXX'+_verifyOtpController.arguments['mobile'].toString().substring(_verifyOtpController.arguments['mobile'].toString().length-2,_verifyOtpController.arguments['mobile'].toString().length),
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 20.px),
                OtpTextField(
                  fieldWidth: MediaQuery.of(context).size.width / 5,
                  borderRadius: BorderRadius.circular(8.px),
                  //  numberOfFields: numberOfFields,
                  borderColor: AppColors.appGrey,
                  enabledBorderColor: (_verifyOtpController.isCorrect.value)
                      ? AppColors.appLightGrey
                      : AppColors.appRed,
                  //   focusedBorderColor: primaryColor,
                  // clearText: clearText,
                  showFieldAsBox: true,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16.px),
                  onCodeChanged: (String value) {
                    _verifyOtpController.isCorrect.value = true;
                  },
                  handleControllers:
                      (List<TextEditingController?> controllers) {
                    //VerifyOtpViewModel.enteredOTP = controllers.toString();
                  },
                  //clearText: !VerifyOtpViewModel.isCorrect,
                  onSubmit: (String verificationCode) {
                    _verifyOtpController.enteredOTP.value = verificationCode;
                  }, // end onSubmit
                ),
                SizedBox(height: 10.px),
                if (!_verifyOtpController.isCorrect.value)
                  AppText(
                    'otpIncorrect'.tr,
                    fontSize: 12.px,
                    fontWeight: FontWeight.w400,
                    color: AppColors.appRed,
                  ),
                SizedBox(height: 20.px),
                AppText(
                  'didntReceived'.tr,
                  fontSize: 12.px,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appGrey,
                ),
                SizedBox(height: 12.px),
                if (_verifyOtpController.isTimerRunning.value)
                  Countdown(
                    controller: _verifyOtpController.timerController,
                    seconds: 180,
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
                      _verifyOtpController.isTimerRunning.value = false;
                    },
                  ),
                SizedBox(height: 12.px),
                GestureDetector(
                  onTap: (!_verifyOtpController.isTimerRunning.value)
                      ? () {
                    _verifyOtpController.reSendOtp();
                  }
                      : () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppImageAsset(
                          image: ImageConstants.arrowRotate,
                          height: 20.px,
                          color: (_verifyOtpController.isTimerRunning.value)
                              ? AppColors.appBlue.withOpacity(0.3)
                              : AppColors.appBlue),
                      SizedBox(width: 5.px),
                      AppText(
                        'sendAgain'.tr,
                        fontSize: 13.px,
                        fontWeight: FontWeight.w600,
                        color: (_verifyOtpController.isTimerRunning.value)
                            ? AppColors.appBlue.withOpacity(0.3)
                            : AppColors.appBlue,
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
          onTap: () => _verifyOtpController.onTapSubmit(context),
          isDisable: _verifyOtpController.enteredOTP.value.length != 4,
        ),
      );
    });
  }
}
