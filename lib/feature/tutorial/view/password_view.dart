import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../custom/sheet/app_bottom_sheet.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/tutorial_view_model.dart';
import 'bottomSheets/term&condition_bottom_sheet.dart';
import 'mobile_view.dart';

class PasswordView extends StatelessWidget {
  const PasswordView({super.key});

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
              body: PreLoginCustomBody(
                widget: Expanded(
                  child: ListView(
                    physics: const PageScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 15.px),
                    children: <Widget>[
                      SizedBox(height: 35.px),
                      const OnTapBack(),
                      SizedBox(height: 60.px),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          textAlign: TextAlign.start,
                          'Create Password',
                          fontSize: 24.px,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20.px),
                      AppTextFormField(
                        title: 'Password',
                        hintText: 'Enter yourPassword',
                        fillColor: AppColors.appWhite,
                        suffix: Padding(
                          padding: EdgeInsets.all(13.px),
                          child: AppImageAsset(
                            image: ImageConstants.eyeCross,
                            height: 10.px,
                          ),
                        ),
                      ),
                      AppTextFormField(
                        title: 'Retype Password',
                        hintText: 'Enter your password again',
                        fillColor: AppColors.appWhite,
                        suffix: Padding(
                          padding: EdgeInsets.all(13.px),
                          child: AppImageAsset(
                            image: ImageConstants.eyeCross,
                            height: 10.px,
                          ),
                        ),
                      ),
                      SizedBox(height: 18.px),
                      AppText(
                        'Password Criteria:',
                        fontSize: 14.px,
                      ),
                      SizedBox(height: 5.px),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                            tutorialViewModel.passWordCriteria.length,
                            (int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.px),
                            child: Row(
                              children: <Widget>[
                                AppImageAsset(
                                  image: (true)
                                      ? ImageConstants.checkbox
                                      : ImageConstants.checkbox,
                                  height: 18.px,
                                ),
                                SizedBox(width: 8.px),
                                AppText(
                                  tutorialViewModel.passWordCriteria[index],
                                  fontSize: 12.px,
                                )
                              ],
                            ),
                          );
                        }),
                      )
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
                        'I have read and accept',
                        fontSize: 14.px,
                      ),
                      SizedBox(width: 5.px),
                      GestureDetector(
                        onTap: () => appBottomSheet(
                            commonWidget: TermAndConditionBottomSheet(),
                            context: context),
                        child: AppText(
                          'Terms & Conditions',
                          fontSize: 14.px,
                          color: AppColors.appBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.px),
                PreLoginCommonButton(
                  title: 'Continue',
                  onTap: () => AppRouter.pushNamed(Routes.homeViews),
                )
              ]),
            );
          });
        });
  }
}
