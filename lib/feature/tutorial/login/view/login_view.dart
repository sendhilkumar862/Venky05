import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/cardView/warning_card_view.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/validators.dart';
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
        onPageBuilder: (BuildContext context, LoginViewModel loginViewModel) {
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
                              errorText: loginViewModel.emailErrorText,
                              onChanged: (String value) {
                                loginViewModel.validateEmail(value);
                              },
                            ),
                            SizedBox(height: 10.px),
                            StatefulBuilder(
                              builder: (BuildContext context, setState) {
                                return TextFormsField(
                                  title: 'password'.tr(),
                                  controller: loginViewModel.passwordController,
                                  hintText: 'enterYourPassword'.tr(),
                                  obscureText: loginViewModel.isPasswordShow,
                                  maxLines: 1,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      loginViewModel.isPasswordShow = !loginViewModel.isPasswordShow;
                                      setState((){});
                                    },
                                    child: AppImageAsset(
                                      image: (loginViewModel.isPasswordShow)
                                          ? ImageConstants.eyeCross
                                          : ImageConstants.eye,
                                      height: 22.px,
                                    ),
                                  ),
                                  onChanged: (String value) {
                                    loginViewModel.onPasswordChanged(value);
                                    setState(() {});
                                  },
                                  onSaved: (String value) => loginViewModel.login(),
                                );
                              },
                            ),
                            SizedBox(
                              height: 20.px,
                            ),
                            if (loginViewModel.loginStatus == 'error')
                              WarningCardView(
                                  color: AppColors.appLightRedTwo, error: loginViewModel.loginModel.status!.message),
                            SizedBox(height: 20.px),
                            if (false)
                              AppImageAsset(
                                image: ImageConstants.faceId,
                                height: 35.px,
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  PreLoginCommonButton(
                    onTap: () => loginViewModel.onTapLoginSubmit(),
                    title: 'login'.tr(),
                    height: 15.px,
                    isDisable: loginViewModel.isButtonDisabled,
                  ),
                  GestureDetector(
                    onTap: () => AppRouter.pushNamed(Routes.forgotPasswordView),
                    child: AppText(
                      'Forgot Password!',
                      fontSize: 14.px,
                      fontWeight: FontWeight.w600,
                      color: AppColors.appBlue,
                    ),
                  ),
                  SizedBox(
                    height: 30.px,
                  )
                ],
              ),
            );
          });
        });
  }
}
