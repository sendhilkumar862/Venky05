import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/countdown_timer/timer_controller.dart';
import '../../../../custom/countdown_timer/timer_count_down.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/otp/otp_text_field.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/validators.dart';
import '../verify_otp_view_model/verify_otp_view_model.dart';

class VerifyOtpView extends StatelessWidget {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyOtpViewModel>(
        viewModel: VerifyOtpViewModel(),
        onModelReady: (VerifyOtpViewModel VerifyOtpViewModel) {
          VerifyOtpViewModel.setContext(context);
          VerifyOtpViewModel.init();
          VerifyOtpViewModel.arguments = ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
          VerifyOtpViewModel.otpId = VerifyOtpViewModel.arguments['otp_id'].toString();
        },
        onPageBuilder: (BuildContext context, VerifyOtpViewModel verifyOtpViewModel) {
          return Observer(builder: (BuildContext context) {
            return Scaffold(
              body: PreLoginCustomBody(
                widget: Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 15.px),
                    children: <Widget>[
                      SizedBox(height: 10.px),
                      const SafeArea(bottom: false, child: OnTapBack()),
                      SizedBox(height: 45.px),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          textAlign: TextAlign.start,
                          (verifyOtpViewModel.arguments['isScreen'])
                              ? 'verifyEmailAddress'.tr()
                              : 'verifyMobileNumber'.tr(),
                          fontSize: 24.px,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 15.px),
                      AppText(
                        textAlign: TextAlign.start,
                        (verifyOtpViewModel.arguments['isScreen'])
                            ? 'enterTheVerification'.tr()
                            : 'enterTheCodeWe'.tr(),
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 20.px),
                      OtpTextField(
                        fieldWidth: MediaQuery.of(context).size.width / 5,
                        borderRadius: BorderRadius.circular(8.px),
                        //  numberOfFields: numberOfFields,
                        borderColor: AppColors.appGrey,
                        enabledBorderColor: (verifyOtpViewModel.isCorrect) ? AppColors.appLightGrey : AppColors.appRed,
                        //   focusedBorderColor: primaryColor,
                        // clearText: clearText,
                        showFieldAsBox: true,
                        textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.px),
                        onCodeChanged: (String value) {
                          verifyOtpViewModel.isCorrect = true;
                        },
                        handleControllers: (List<TextEditingController?> controllers) {
                          //VerifyOtpViewModel.enteredOTP = controllers.toString();
                        },
                        //clearText: !VerifyOtpViewModel.isCorrect,
                        onSubmit: (String verificationCode) {
                          verifyOtpViewModel.enteredOTP = verificationCode;
                        }, // end onSubmit
                      ),
                      SizedBox(height: 10.px),
                      if (!verifyOtpViewModel.isCorrect)
                        AppText(
                          'otpIncorrect'.tr(),
                          fontSize: 12.px,
                          fontWeight: FontWeight.w400,
                          color: AppColors.appRed,
                        ),
                      SizedBox(height: 20.px),
                      AppText(
                        'didntReceived'.tr(),
                        fontSize: 12.px,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                        color: AppColors.appGrey,
                      ),
                      SizedBox(height: 12.px),
                      Countdown(
                        controller: verifyOtpViewModel.timerController,
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
                          verifyOtpViewModel.isTimerRunning = false;
                        },
                      ),
                      SizedBox(height: 12.px),
                      GestureDetector(
                        onTap: (!verifyOtpViewModel.isTimerRunning)
                            ? () {
                                verifyOtpViewModel.reSendOtp();
                              }
                            : () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AppImageAsset(
                                image: ImageConstants.arrowRotate,
                                height: 20.px,
                                color: (verifyOtpViewModel.isTimerRunning)
                                    ? AppColors.appBlue.withOpacity(0.3)
                                    : AppColors.appBlue),
                            SizedBox(width: 5.px),
                            AppText(
                              'sendAgain'.tr(),
                              fontSize: 13.px,
                              fontWeight: FontWeight.w600,
                              color: (verifyOtpViewModel.isTimerRunning)
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
                title: 'continue'.tr(),
                onTap: () => verifyOtpViewModel.onTapSubmit(),
                isDisable: verifyOtpViewModel.enteredOTP.length != 4,
              ),
            );
          });
        });
  }
}
