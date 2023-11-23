import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/text_field.dart';
import '../../../custom/cardView/warning_card_view.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/tutorial_view_model.dart';

class ForgotPassWordView extends StatelessWidget {
  const ForgotPassWordView({super.key});

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
              body: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  const AppImageAsset(
                    image: ImageConstants.splashBG,
                    fit: BoxFit.fill,
                  ),
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 15.px),
                          children: <Widget>[
                            SizedBox(height: 10.px),
                            const SafeArea(bottom: false, child: OnTapBack()),
                            SizedBox(height: 60.px),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: AppImageAsset(
                                image: ImageConstants.primaryLogoBlue,
                                height: 45.px,
                              ),
                            ),
                            SizedBox(height: 28.px),
                            AppText(
                              textAlign: TextAlign.start,
                              'Forgot Password!',
                              fontSize: 24.px,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: 10.px),
                            TextFormsField(
                              title: 'emailAdd'.tr(),
                              validate: tutorialViewModel.emailValid,
                              controller:
                                  tutorialViewModel.forgotEmailController,
                              hintText: 'enterEmail'.tr(),
                              errorText: tutorialViewModel.emailErrorText!,
                              onChanged: (String value) {
                                tutorialViewModel.validateEmail(value);
                              },
                            ),
                            /*                TextFormsField(
                              title: 'emailAdd'.tr(),
                              keyboardType: TextInputType.text,
                              hintText: 'Enter your email address',
                              controller:
                                  tutorialViewModel.forgotEmailController,
                              errorText: loginViewModel.emailErrorText!,
                              onChanged: (String value) {
                                tutorialViewModel.validateEmail(value);
                              },
                            ),*/
                            SizedBox(
                              height: 20.px,
                            ),
                            if (tutorialViewModel.errors.isNotEmpty)
                              WarningCardView(
                                  color: (tutorialViewModel
                                              .resetPassEmailResponseModel
                                              .status!
                                              .type ==
                                          'error')
                                      ? AppColors.appLightRedTwo
                                      : AppColors.lightPurple,
                                  error: tutorialViewModel.errors),
                            SizedBox(height: 20.px),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.px),
                        child: AppButton(
                          height: 45.px,
                          borderRadius: BorderRadius.circular(10.px),
                          borderColor: AppColors.appBlue,
                          isDisable: tutorialViewModel.isButtonDisabled,
                          title: 'Reset Password',
                          onPressed: () {
                            if (!tutorialViewModel.isButtonDisabled) {
                              showLoading();
                              tutorialViewModel.forgotPassword();
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 15.px),
                      GestureDetector(
                        onTap: () => AppRouter.pushNamed(Routes.loginView),
                        child: AppText(
                          'Log In',
                          fontSize: 14.px,
                          fontWeight: FontWeight.w600,
                          color: AppColors.appBlue,
                        ),
                      ),
                      SizedBox(
                        height: 40.px,
                      )
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }
}
