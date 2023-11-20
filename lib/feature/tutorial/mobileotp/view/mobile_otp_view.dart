import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/countdown_timer/timer_count_down.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/otp/otp_text_field.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';

import '../viewModel/mobile_otp_view_model.dart';

class MobileOtpView extends StatelessWidget {
  const MobileOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MobileOtpViewModel>(
        viewModel: MobileOtpViewModel(),
        onModelReady: (MobileOtpViewModel mobileOtpViewModel) {
          mobileOtpViewModel.setContext(context);
          mobileOtpViewModel.enteredMobile =
              ModalRoute.of(context)!.settings.arguments.toString();
        },
        onPageBuilder:
            (BuildContext context, MobileOtpViewModel mobileOtpViewModel) {
          return Observer(builder: (BuildContext context) {
            return Scaffold(
              body: PreLoginCustomBody(
                widget: Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 15.px),
                    children: [
                      SizedBox(height: 35.px),
                      const OnTapBack(),
                      SizedBox(height: 100.px),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          textAlign: TextAlign.start,
                          'verifyMobileNumber'.tr(),
                          fontSize: 24.px,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 15.px),
                       AppText(
                        textAlign: TextAlign.start,
                        'enterTheCodeWe'.tr(),
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 20.px),
                      OtpTextField(
                        fieldWidth: 73.px,
                        borderRadius: BorderRadius.circular(8.px),
                        //  numberOfFields: numberOfFields,
                        borderColor: AppColors.appGrey,

                        enabledBorderColor: (mobileOtpViewModel.isCorrect)
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
                          mobileOtpViewModel.enteredOTP = verificationCode;
                        }, // end onSubmit
                      ),
                      SizedBox(height: 10.px),
                      if (!mobileOtpViewModel.isCorrect)
                        AppText(
                          'otpIncorrect'.tr(),
                          fontSize: 12.px,
                          fontWeight: FontWeight.w400,
                          color: AppColors.appRed,
                        ),
                      SizedBox(
                        height: 20.px,
                      ),
                      AppText("sendAgain".tr(),
                          fontSize: 12.px,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                          color: AppColors.appGrey),
                      SizedBox(height: 12.px),
                      AppText(
                        '00:30',
                        color: AppColors.appPurple,
                        fontWeight: FontWeight.w700,
                        fontSize: 24.px,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.px),
                      GestureDetector(
                        onTap: () => CountdownController(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppImageAsset(
                                image: ImageConstants.arrowRotate,
                                height: 20.px),
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
                onTap: () => AppRouter.pushNamed(Routes.userInfoView),
                isDisable: mobileOtpViewModel.enteredOTP.length != 4,
              ),
            );
          });
        });
  }
}
