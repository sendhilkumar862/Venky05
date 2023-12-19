import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/cardView/warning_card_view.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../getxController/signin_controller.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';


class LoginView extends StatelessWidget {
   LoginView({super.key});
  final SignInController _signInController=Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
    Scaffold(
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
                      SafeArea(bottom: false, child: OnTapBack()),
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
                        validate: _signInController.emailValid.value,
                        controller: _signInController.emailController,
                        hintText: 'enterEmail'.tr(),
                        errorText: _signInController.emailErrorText.value,
                        onChanged: (String value) {
                          _signInController.validateEmail(value);
                        },
                      ),
                      SizedBox(height: 10.px),
                      StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          return TextFormsField(
                            title: 'password'.tr(),
                            controller: _signInController.passwordController,
                            hintText: 'enterYourPassword'.tr(),
                            obscureText: _signInController.isPasswordShow.value,
                            maxLines: 1,
                            suffixIcon: InkWell(
                              onTap: () {
                                _signInController.isPasswordShow.value = !_signInController.isPasswordShow.value;
                                setState(() {});
                              },
                              child: AppImageAsset(
                                image: (_signInController.isPasswordShow.value)
                                    ? ImageConstants.eyeCross
                                    : ImageConstants.eye,
                                height: 22.px,
                              ),
                            ),
                            onChanged: (String value) {
                              _signInController.onPasswordChanged(value);
                              setState(() {});
                            },
                            onSaved: (String value) => _signInController.login(),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20.px,
                      ),
                      if (_signInController.loginStatus.value == 'error')
                        WarningCardView(
                            color: AppColors.appLightRedTwo, error: _signInController.error.value),
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
              onTap: () =>  !_signInController.isButtonDisabled.value?_signInController.onTapLoginSubmit():null,
              title: 'login'.tr(),
              height: 15.px,
              isDisable: _signInController.isButtonDisabled.value,
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
      ),
    );
  }
}
