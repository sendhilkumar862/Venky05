import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/tutorial_view_model.dart';
import 'otp_view.dart';

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
                  Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 15.px),
                          children: [
                            SizedBox(height: 35.px),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: AppImageAsset(
                                  image: ImageConstants.backIcon,
                                  height: 25.px,
                                ),
                              ),
                            ),
                            SizedBox(height: 80.px),
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
                            AppTextFormField(
                              // titleColor: (walletViewModel.nameError.isEmpty)
                              //     ? AppColors.appGrey
                              //     : ('valid' == walletViewModel.nameError)
                              //     ? AppColors.appRed
                              //     : AppColors.appBlue,
                              controller: tutorialViewModel.emailController,
                              title: 'Email Address',
                              keyboardType: TextInputType.text,
                              hintText: 'Enter your email address',
                              validate: (String? value) {
                                // return walletViewModel.nameValidation(value!);
                              },
                            ),
                            SizedBox(
                              height: 20.px,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.px),
                        child: AppButton(
                          height: 45.px,
                          borderRadius: BorderRadius.circular(10.px),
                          borderColor: AppColors.appBlue,
                          title: 'Reset Password',
                          onPressed: () {
                            AppRouter.pushNamed(Routes.restPassword);
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
                  const AppImageAsset(
                    image: ImageConstants.splashBG,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            );
          });
        });
  }
}
