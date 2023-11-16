import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../custom/app_textformfield/text_field.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../custom/sheet/app_bottom_sheet.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/tutorial_view_model.dart';
import 'bottomSheets/term&condition_bottom_sheet.dart';

class PasswordView extends StatelessWidget {
  const PasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<TutorialViewModel>(
        viewModel: TutorialViewModel(),
        onModelReady: (TutorialViewModel tutorialViewModel) {
          tutorialViewModel.setContext(context);
          tutorialViewModel.data = (ModalRoute.of(context)!.settings.arguments!  as Map)!;
        },
        onPageBuilder:
            (BuildContext context, TutorialViewModel tutorialViewModel) {
          return Observer(builder: (BuildContext context) {
            return Scaffold(
              body: PreLoginCustomBody(
                widget: Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 35.px),
                      Padding(
                        padding: EdgeInsets.only(left: 10.px),
                        child: const OnTapBack(),
                      ),
                      SizedBox(height: 20.px),
                      Expanded(
                        child: ListView(
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
                              controller: tutorialViewModel.passwordController,
                              hintText: 'enterYourPassword'.tr(),
                              obscureText: true,
                              suffixIcon: AppImageAsset(
                                image: ImageConstants.eyeCross,
                                height: 22.px,
                              ),
                              onChanged: (String value) {
                                tutorialViewModel.validatePassword(value!);
                              },
                            ),
                            SizedBox(height: 10.px),
                            TextFormsField(
                              title: 'retypePassword'.tr(),
                              controller:
                                  tutorialViewModel.retypePasswordController,
                              hintText: 'enterYourPasswordAgain'.tr(),
                               obscureText: true,
                              suffixIcon: AppImageAsset(
                                image: ImageConstants.eyeCross,
                                height: 22.px,
                              ),
                              onChanged: (String value) {
                                tutorialViewModel
                                    .validateRetypePassword(value!);
                              },
                            ),
                            SizedBox(height: 18.px),
                            AppText(
                              'passwordCriteria'.tr(),
                              fontSize: 14.px,
                            ),
                            SizedBox(height: 5.px),
                            Observer(
                              builder: (context) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                      tutorialViewModel.passWordCriteria.length,
                                      (int index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.px),
                                      child: Row(
                                        children: <Widget>[
                                          AppImageAsset(
                                            image: (!tutorialViewModel
                                                    .isPassWordCriteria[index])
                                                ? ImageConstants.checkbox
                                                : ImageConstants.checkboxFilled,
                                            height: 18.px,
                                          ),
                                          SizedBox(width: 8.px),
                                          AppText(
                                            tutorialViewModel
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar:
                  Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.px),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => tutorialViewModel.onTapTermAndCondition(),
                        child: AppImageAsset(
                          image: (tutorialViewModel.isActive)
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
                            commonWidget: TermAndConditionBottomSheet(),
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
                  onTap: () => tutorialViewModel.onTapSubmitPassword(),
                  isDisable:
                      tutorialViewModel.isPassWordCriteria.contains(false),
                )
              ]),
            );
          });
        });
  }
}
