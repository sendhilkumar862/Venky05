import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/cardView/warning_card_view.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../viewModel/login_view_model.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        viewModel: LoginViewModel(),
        onModelReady: (LoginViewModel loginViewModel) {
          loginViewModel.setContext(context);
          loginViewModel.init();
        },
        onPageBuilder:
            (BuildContext context, LoginViewModel loginViewModel) {
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
                              'Login To Hessah',
                              fontSize: 24.px,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: 10.px),
                            TextFormsField(
                              title: 'emailAdd'.tr(),
                              validate: loginViewModel.emailValid,
                              controller: loginViewModel.emailController,
                              hintText: 'enterEmail'.tr(),
                              errorText: loginViewModel.emailErrorText!,
                              onChanged: (String value) {
                                loginViewModel.validateEmail(value!);
                              },
                            ),

                            SizedBox(height: 2.px),
                            TextFormsField(
                              title: 'password'.tr(),
                              controller:
                              loginViewModel.passwordController,
                              hintText: 'enterYourPassword'.tr(),
                              obscureText: true,
                              suffixIcon: AppImageAsset(
                                image: ImageConstants.eyeCross,
                                height: 22.px,
                              ),
                              onChanged: (String value) {
                              },
                            ),
                            SizedBox(
                              height: 20.px,
                            ),
                            if(false)WarningCardView(
                              color: (true)
                                  ? AppColors.lightPurple
                                  : AppColors.appLightRedTwo,
                              error: (true)
                                  ? 'Email already existing'
                                  : 'Your Credentials are wrong',
                            ),
                            SizedBox(height: 20.px),
                            AppImageAsset(
                              image: ImageConstants.faceId,
                              height: 35.px,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.px),
                        child: AppButton(
                          height: 45.px,
                          borderRadius: BorderRadius.circular(10.px),
                          borderColor: AppColors.appBlue,
                          title: 'Login',
                          onPressed: () => loginViewModel.onTapLoginSubmit(),
                        ),
                      ),
                      SizedBox(height: 15.px),
                      GestureDetector(
                        onTap: () =>
                            AppRouter.pushNamed(Routes.forgotPasswordView),
                        child: AppText(
                          'Forgot Password!',
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
