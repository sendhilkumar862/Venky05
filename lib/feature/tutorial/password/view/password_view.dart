import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hessah/config/routes/app_router.dart';
import 'package:hessah/config/routes/routes.dart';
import 'package:hessah/feature/preference/view/preference_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/sheet/app_bottom_sheet.dart';
import '../../../../custom/sheet/show_bottom_sheet.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/app/app_constants.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../../view/bottomSheets/term&condition_bottom_sheet.dart';
import '../viewModel/password_view_model.dart';

class PasswordView extends StatelessWidget {
  PasswordView({super.key});

  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  String selectedProfile = '';

  @override
  Widget build(BuildContext context) {
    return BaseView<PasswordViewModel>(
        viewModel: PasswordViewModel(),
        onModelReady: (PasswordViewModel passwordViewModel) {
          passwordViewModel.setContext(context);
          passwordViewModel.init();
          passwordViewModel.arguments =
              (ModalRoute.of(context)!.settings.arguments! as Map) ?? {};

          logs('argue--> ${passwordViewModel.arguments}');
        },
        onPageBuilder:
            (BuildContext context, PasswordViewModel passwordViewModel) {
          return Observer(builder: (BuildContext context) {
            return Scaffold(
              body: PreLoginCustomBody(
                widget: Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 35.px),
                      Padding(
                        padding: EdgeInsets.only(left: 10.px),
                        child: const OnTapBack(),
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
                                  'createPassword'.tr(),
                                  fontSize: 24.px,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 20.px),
                              TextFormsField(
                                title: 'password'.tr(),
                                controller:
                                    passwordViewModel.passwordController,
                                hintText: 'enterYourPassword'.tr(),
                                keyboardType: TextInputType.multiline,
                                obscureText:
                                    !passwordViewModel.isPasswordVisible,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    passwordViewModel.isPasswordVisible =
                                        !passwordViewModel.isPasswordVisible;
                                    setState(() {});
                                  },
                                  child: AppImageAsset(
                                    image: (passwordViewModel.isPasswordVisible)
                                        ? ImageConstants.eyeCross
                                        : ImageConstants.eye,
                                    height: 22.px,
                                  ),
                                ),
                                onChanged: (String value) {
                                  passwordViewModel.validatePassword(
                                      value, setState);
                                },
                              ),
                              SizedBox(height: 10.px),
                              TextFormsField(
                                keyboardType: TextInputType.multiline,
                                title: 'retypePassword'.tr(),
                                controller:
                                    passwordViewModel.retypePasswordController,
                                hintText: 'enterYourPasswordAgain'.tr(),
                                obscureText:
                                    !passwordViewModel.isPasswordVisible,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    passwordViewModel.isPasswordVisible =
                                        !passwordViewModel.isPasswordVisible;
                                    setState(() {});
                                  },
                                  child: AppImageAsset(
                                    image: (passwordViewModel.isPasswordVisible)
                                        ? ImageConstants.eyeCross
                                        : ImageConstants.eye,
                                    height: 22.px,
                                  ),
                                ),
                                onChanged: (String value) {
                                  passwordViewModel.validateRetypePassword(
                                      value!, setState);
                                },
                              ),
                              SizedBox(height: 18.px),
                              AppText(
                                'passwordCriteria'.tr(),
                                fontSize: 14.px,
                              ),
                              SizedBox(height: 5.px),
                              Observer(
                                builder: (BuildContext context) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: List.generate(
                                        passwordViewModel.passWordCriteria
                                            .length, (int index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.px),
                                        child: Row(
                                          children: <Widget>[
                                            AppImageAsset(
                                              image: (!passwordViewModel
                                                          .isPassWordCriteria[
                                                      index])
                                                  ? ImageConstants.checkbox
                                                  : ImageConstants
                                                      .checkboxFilled,
                                              height: 18.px,
                                            ),
                                            SizedBox(width: 8.px),
                                            AppText(
                                              passwordViewModel
                                                  .passWordCriteria[index],
                                              fontSize: 12.px,
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                  );
                                },
                              )
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
                      GestureDetector(
                        onTap: () => passwordViewModel.onTapTermAndCondition(),
                        child: AppImageAsset(
                          image: (passwordViewModel.isActive)
                              ? ImageConstants.checkboxSqureFilled
                              : ImageConstants.checkboxSqure,
                          height: 18.px,
                        ),
                      ),
                      SizedBox(width: 6.px),
                      AppText(
                        'iHaveRead'.tr(),
                        fontSize: 14.px,
                      ),
                      SizedBox(width: 5.px),
                      GestureDetector(
                        onTap: () => appBottomSheet(
                            commonWidget: TermAndConditionBottomSheet(
                                passwordViewModel: passwordViewModel),
                            context: context),
                        child: AppText(
                          't&c'.tr(),
                          fontSize: 14.px,
                          color: AppColors.appBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.px),
                PreLoginCommonButton(
                    title: 'continue'.tr(),
                    onTap: passwordViewModel.isButtonActive
                        ? () async {
                            final bool success =
                                await passwordViewModel.onTapSubmitPassword();
                            if (success) {
                              selectedProfile = keyValueStorageBase.getCommon(
                                  String, KeyValueStorageService.profile);
                              if (selectedProfile ==
                                  ApplicationConstants.student) {
                                await Future.delayed(
                                    const Duration(seconds: 1));

                                if (!context.mounted) {
                                  return;
                                }
                                showCommonBottomSheet(
                                    context: context,
                                    commonWidget: const PreferenceView());
                              } else {
                                AppRouter.pushNamed(Routes.HomeScreenRoute);
                              }
                            }
                          }
                        : () {},
                    isDisable: !passwordViewModel.isButtonActive)
              ]),
            );
          });
        });
  }
}
