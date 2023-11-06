import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/countdown_timer/timer_count_down.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/otp/otp_text_field.dart';
import '../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/tutorial_view_model.dart';
import 'mobile_view.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<TutorialViewModel>(
        viewModel: TutorialViewModel(),
        onModelReady: (TutorialViewModel tutorialViewModel) {
          tutorialViewModel.setContext(context);
        },
        onPageBuilder:
            (BuildContext context, TutorialViewModel tutorialViewModel) {
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
                          'Verify Mobile Number',
                          fontSize: 24.px,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 15.px),
                      const AppText(
                        textAlign: TextAlign.start,
                        'Enter the verification code we sent to email address ending with **in',
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 20.px),
                      OtpTextField(
                        fieldWidth: 73.px,
                        borderRadius: BorderRadius.circular(8.px),
                        //    numberOfFields: numberOfFields,
                        borderColor: const Color(0xFF512DA8),
                        //   focusedBorderColor: primaryColor,
                        // clearText: clearText,
                        showFieldAsBox: true,
                        //  textStyle: theme.textTheme.subtitle1,
                        onCodeChanged: (String value) {
                          //Handle each value
                        },
                        handleControllers:
                            (List<TextEditingController?> controllers) {
                          //get all textFields controller, if needed
                          //   controls = controllers;
                        },
                        onSubmit: (String verificationCode) {
                          //set clear text to clear text from all fields
                          //   clearText = true;
                          //navigate to different screen code goes here
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const AppText('Verification Code'),
                                content: AppText(
                                    'Code entered is $verificationCode'),
                              );
                            },
                          );
                        }, // end onSubmit
                      ),
                      SizedBox(
                        height: 20.px,
                      ),
                      AppText("Didn't receive the verification code?",
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
                              'Resend Again',
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
                title: 'Continue',
                onTap: () => AppRouter.pushNamed(Routes.userInfoView),
              ),
            );
          });
        });
  }
}
