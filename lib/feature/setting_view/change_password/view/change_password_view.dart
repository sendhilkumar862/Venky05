import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

final ChangePasswordController _changePasswordController =
    Get.put(ChangePasswordController());

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        leadingTap: () {
          _changePasswordController.backButtonTapped();
          Get.back();
        },
        title: 'changePassword'.tr,
        isTitleOnly: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10.px),
                Expanded(child: StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 15.px),
                      children: <Widget>[
                        Obx(
                          () => TextFormsField(
                            validate: _changePasswordController
                                    .isWrongOldPassword.value
                                ? 0
                                : null,
                            title: 'Old Password'.tr,
                            controller:
                                _changePasswordController.oldPasswordController,
                            hintText: 'Enter Your Old Password'.tr,
                            keyboardType: TextInputType.multiline,
                            obscureText: !_changePasswordController
                                .isOldPasswordVisible.value,
                            suffixIcon: InkWell(
                              onTap: () {
                                _changePasswordController
                                        .isOldPasswordVisible.value =
                                    !_changePasswordController
                                        .isOldPasswordVisible.value;
                              },
                              child: AppImageAsset(
                                image: (_changePasswordController
                                        .isOldPasswordVisible.value)
                                    ? ImageConstants.eye
                                    : ImageConstants.eyeCross,
                                height: 22.px,
                              ),
                            ),
                            onChanged: (String value) {
                              // _changePasswordController.validatePassword(
                              //     value, setState);
                            },
                          ),
                        ),
                        Obx(() =>
                            _changePasswordController.isWrongOldPassword.value
                                ? AppText(
                                    'Password Incorrect. ${_changePasswordController.noOfAttempts.value} attempts remaining.',
                                    color: AppColors.appRed,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )
                                : const SizedBox.shrink()),
                        SizedBox(height: 10.px),
                        Obx(
                          () => TextFormsField(
                            title: 'New Password'.tr,
                            controller:
                                _changePasswordController.passwordController,
                            hintText: 'Enter Your New Password'.tr,
                            keyboardType: TextInputType.multiline,
                            obscureText: !_changePasswordController
                                .isPasswordVisible.value,
                            suffixIcon: InkWell(
                              onTap: () {
                                _changePasswordController
                                        .isPasswordVisible.value =
                                    !_changePasswordController
                                        .isPasswordVisible.value;
                              },
                              child: AppImageAsset(
                                image: (_changePasswordController
                                        .isPasswordVisible.value)
                                    ? ImageConstants.eye
                                    : ImageConstants.eyeCross,
                                height: 22.px,
                              ),
                            ),
                            onChanged: (String value) {
                              _changePasswordController.validatePassword(
                                  value, setState);
                            },
                          ),
                        ),
                        SizedBox(height: 10.px),
                        Obx(
                          () => TextFormsField(
                            keyboardType: TextInputType.multiline,
                            title: 'Retype New Password'.tr,
                            controller: _changePasswordController
                                .retypedPasswordController,
                            hintText: 'Enter Your New Password Again'.tr,
                            obscureText: !_changePasswordController
                                .isRetypePasswordVisible.value,
                            suffixIcon: InkWell(
                              onTap: () {
                                _changePasswordController
                                        .isRetypePasswordVisible.value =
                                    !_changePasswordController
                                        .isRetypePasswordVisible.value;
                              },
                              child: AppImageAsset(
                                image: (_changePasswordController
                                        .isRetypePasswordVisible.value)
                                    ? ImageConstants.eye
                                    : ImageConstants.eyeCross,
                                height: 22.px,
                              ),
                            ),
                            onChanged: (String value) {
                              _changePasswordController.validateRetypePassword(
                                  value, setState);
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
                          children: List.generate(
                              _changePasswordController.passWordCriteria.length,
                              (int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.px),
                              child: Row(
                                children: <Widget>[
                                  AppImageAsset(
                                    image: (!_changePasswordController
                                            .isPassWordCriteria[index])
                                        ? ImageConstants.checkbox
                                        : ImageConstants.checkboxFilled,
                                    height: 18.px,
                                  ),
                                  SizedBox(width: 8.px),
                                  AppText(
                                    _changePasswordController
                                        .passWordCriteria[index],
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
        ],
      ),
      bottomNavigationBar:
          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 15.px),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: <Widget>[
        //       Obx(
        //             () => GestureDetector(
        //           onTap: () => _changePasswordController.onTapTermAndCondition(),
        //           child: AppImageAsset(
        //             image: (_changePasswordController.isActive.value)
        //                 ? ImageConstants.checkboxSqureFilled
        //                 : ImageConstants.checkboxSqure,
        //             height: 18.px,
        //           ),
        //         ),
        //       ),
        //       SizedBox(width: 6.px),
        //       AppText(
        //         'iHaveRead'.tr,
        //         fontSize: 14.px,
        //       ),
        //       SizedBox(width: 5.px),
        //       GestureDetector(
        //         onTap: () => appBottomSheet(
        //             commonWidget: TermAndConditionBottomSheet(),
        //             context: context),
        //         child: AppText(
        //           't&c'.tr,
        //           fontSize: 14.px,
        //           color: AppColors.appBlue,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(height: 15.px),
        Obx(
          () => PreLoginCommonButton(
              title: 'continue'.tr,
              onTap: _changePasswordController.isButtonActive.value
                  ? () async {
                      final bool success = await _changePasswordController
                          .requestChangePassword();
                      if (success) {
                        // ignore: use_build_context_synchronously
                        showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 30,
                            // here increase or decrease in width
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          builder: (BuildContext context) {
                            return SuccessFailsInfoDialog(
                              title: 'success'.tr,
                              buttonTitle: 'done'.tr,
                              content: 'youHaveSuccessfully'.tr,
                              isRouting: 'back',
                            );
                          },
                        );
                      }
                    }
                  : () {},
              isDisable: !_changePasswordController.isButtonActive.value),
        )
      ]),
    );
  }
}
