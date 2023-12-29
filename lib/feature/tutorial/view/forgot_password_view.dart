
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../tutorial_controller/tutorial_controller.dart';


class ForgotPassWordView extends StatelessWidget {
   ForgotPassWordView({super.key});
  final TutorialController _tutorialController =Get.put(TutorialController());
  @override
  Widget build(BuildContext context) {
    return   Obx(()=>
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
                        'Forgot Password!',
                        fontSize: 24.px,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 10.px),
                      TextFormsField(
                        title: 'emailAdd'.tr,
                        validate: _tutorialController.emailValid.value,
                        controller:
                        _tutorialController.forgotEmailController,
                        hintText: 'enterEmail'.tr,
                        errorText: _tutorialController.emailErrorText!.value,
                        onChanged: (String value) {
                          _tutorialController.validateEmail(value);
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
                      if (_tutorialController.errors.value.isNotEmpty)
                        WarningCardView(
                            color: AppColors.appLightRedTwo,
                            error: _tutorialController.errors.value),
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
                    isDisable: _tutorialController.isButtonDisabled.value,
                    title: 'Reset Password',
                    onPressed: () {
                      if (!_tutorialController.isButtonDisabled.value) {
                        showLoading();
                        _tutorialController.forgotPassword();
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
      ),
    );
  }
}
