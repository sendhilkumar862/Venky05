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
import '../viewModel/email_otp_view_model.dart';

class EmailOtpView extends StatelessWidget {
  const EmailOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<EmailOtpViewModel>(
        viewModel: EmailOtpViewModel(),
        onModelReady: (EmailOtpViewModel emailOtpViewModel) {
          emailOtpViewModel.setContext(context);
          emailOtpViewModel.init();
          emailOtpViewModel.enteredMail =
              (ModalRoute.of(context)!.settings.arguments! as Map)!;
          logs('argues --> ${emailOtpViewModel.enteredMail}');
        },
        onPageBuilder:
            (BuildContext context, EmailOtpViewModel emailOtpViewModel) {
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
                          'verifyEmailAddress'.tr(),
                          fontSize: 24.px,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 15.px),
                      AppText(
                        textAlign: TextAlign.start,
                        'enterTheVerification'.tr(),
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 20.px),
                      OtpTextField(
                        fieldWidth: MediaQuery.of(context).size.width / 5,
                        borderRadius: BorderRadius.circular(8.px),
                        //  numberOfFields: numberOfFields,
                        borderColor: AppColors.appGrey,

                        enabledBorderColor: (emailOtpViewModel.isCorrect)
                            ? AppColors.appLightGrey
                            : AppColors.appRed,
                        //   focusedBorderColor: primaryColor,
                        // clearText: clearText,
                        showFieldAsBox: true,

                        textStyle: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16.px),
                        onCodeChanged: (String value) {
                          emailOtpViewModel.isCorrect = true;
                        },
                        handleControllers:
                            (List<TextEditingController?> controllers) {
                          //emailOtpViewModel.enteredOTP = controllers.toString();
                        },
                        //clearText: !emailOtpViewModel.isCorrect,
                        onSubmit: (String verificationCode) {
                          emailOtpViewModel.enteredOTP = verificationCode;
                        }, // end onSubmit
                      ),
                      SizedBox(height: 10.px),
                      if (!emailOtpViewModel.isCorrect)
                        AppText(
                          'otpIncorrect'.tr(),
                          fontSize: 12.px,
                          fontWeight: FontWeight.w400,
                          color: AppColors.appRed,
                        ),
                      SizedBox(
                        height: 20.px,
                      ),
                      AppText(
                        'didntReceived'.tr(),
                        fontSize: 12.px,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                        color: AppColors.appGrey,
                      ),
                      SizedBox(height: 12.px),
                      Countdown(
                        controller: emailOtpViewModel.controller,
                        seconds: 180,
                        build: (_, double time) => AppText(
                          AppUtils.formatTimer(time.toInt()),
                          color: AppColors.appPurple,
                          fontWeight: FontWeight.w700,
                          fontSize: 24.px,
                          textAlign: TextAlign.center,
                        ),
                        interval: const Duration(seconds: 1),
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
                              'sendAgain'.tr(),
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
                title: 'continue'.tr(),
                onTap: emailOtpViewModel.onTapSubmit,
                isDisable: emailOtpViewModel.enteredOTP.length != 4,
              ),
            );
          });
        });
  }
}
