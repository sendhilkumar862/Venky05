import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/sheet/app_bottom_sheet.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../view/bottomSheets/term&condition_bottom_sheet.dart';
import '../controller/password_controller.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  final PasswordController _passwordController = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PreLoginCustomBody(
        widget: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 10.px),
              Padding(
                padding: EdgeInsets.only(left: 10.px),
                child: SafeArea(child: OnTapBack()),
              ),
              SizedBox(height: 20.px),
              Expanded(child: StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 15.px),
                    children: <Widget>[
                      SizedBox(height: 45.px),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          textAlign: TextAlign.start,
                          'createPassword'.tr,
                          fontSize: 24.px,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20.px),
                      Obx(
                        () => TextFormsField(
                          title: 'password'.tr,
                          controller: _passwordController.passwordController,
                          hintText: 'enterYourPassword'.tr,
                          keyboardType: TextInputType.multiline,
                          obscureText:
                              !_passwordController.isPasswordVisible.value,
                          suffixIcon: InkWell(
                            onTap: () {
                              _passwordController.isPasswordVisible.value =
                                  !_passwordController.isPasswordVisible.value;
                            },
                            child: AppImageAsset(
                              image:
                                  (_passwordController.isPasswordVisible.value)
                                      ? ImageConstants.eye
                                      : ImageConstants.eyeCross,
                              height: 22.px,
                            ),
                          ),
                          onChanged: (String value) {
                            _passwordController.validatePassword(
                                value, setState);
                          },
                        ),
                      ),
                      SizedBox(height: 10.px),
                      Obx(
                        () => TextFormsField(
                          keyboardType: TextInputType.multiline,
                          title: 'retypePassword'.tr,
                          controller:
                              _passwordController.retypePasswordController,
                          hintText: 'enterYourPasswordAgain'.tr,
                          obscureText: !_passwordController
                              .isRetypePasswordVisible.value,
                          suffixIcon: InkWell(
                            onTap: () {
                              _passwordController
                                      .isRetypePasswordVisible.value =
                                  !_passwordController
                                      .isRetypePasswordVisible.value;
                            },
                            child: AppImageAsset(
                              image: (_passwordController
                                      .isRetypePasswordVisible.value)
                                  ? ImageConstants.eye
                                  : ImageConstants.eyeCross,
                              height: 22.px,
                            ),
                          ),
                          onChanged: (String value) {
                            _passwordController.validateRetypePassword(
                                value!, setState);
                          },
                        ),
                      ),
                      SizedBox(height: 18.px),
                      AppText(
                        'passwordCriteria'.tr,
                        fontSize: 14.px,
                      ),
                      SizedBox(height: 5.px),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                            _passwordController.passWordCriteria.length,
                            (int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.px),
                            child: Row(
                              children: <Widget>[
                                AppImageAsset(
                                  image: (!_passwordController
                                          .isPassWordCriteria[index])
                                      ? ImageConstants.checkbox
                                      : ImageConstants.checkboxFilled,
                                  height: 18.px,
                                ),
                                SizedBox(width: 8.px),
                                AppText(
                                  _passwordController.passWordCriteria[index],
                                  fontSize: 12.px,
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                },
              )),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.px),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Obx(
                () => GestureDetector(
                  onTap: () => _passwordController.onTapTermAndCondition(),
                  child: AppImageAsset(
                    image: (_passwordController.isActive.value)
                        ? ImageConstants.checkboxSqureFilled
                        : ImageConstants.checkboxSqure,
                    height: 18.px,
                  ),
                ),
              ),
              SizedBox(width: 6.px),
              AppText(
                'iHaveRead'.tr,
                fontSize: 14.px,
              ),
              SizedBox(width: 5.px),
              GestureDetector(
                onTap: () => appBottomSheet(
                    commonWidget: TermAndConditionBottomSheet(),
                    context: context),
                child: AppText(
                  't&c'.tr,
                  fontSize: 14.px,
                  color: AppColors.appBlue,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.px),
        Obx(
          () => PreLoginCommonButton(
              title: 'continue'.tr,
              onTap: _passwordController.isButtonActive.value
                  ? () async {
                      final bool success =
                          await _passwordController.registerUser();
                      if (success) {
                        AppRouter.pushNamed(Routes.HomeScreenRoute);
                      }
                    }
                  : () {},
              isDisable: !_passwordController.isButtonActive.value),
        )
      ]),
    );
  }
}
