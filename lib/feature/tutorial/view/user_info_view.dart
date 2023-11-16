import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/app_textformfield/text_field.dart';
import '../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../custom/switch/app_switch.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../viewModel/tutorial_view_model.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key});

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
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 15.px),
                    children: [
                      SizedBox(height: 35.px),
                      const OnTapBack(),
                      SizedBox(height: 20.px),
                      SizedBox(height: 80.px),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          textAlign: TextAlign.start,
                          'userInfo'.tr(),
                          fontSize: 24.px,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20.px),
                      TextFormsField(
                        keyboardType: TextInputType.text,
                        title: 'firstName'.tr(),
                        validate: tutorialViewModel.firstNameValid,
                        controller: tutorialViewModel.firstNameController,
                        hintText: 'enterYourFirstName'.tr(),
                        errorText: tutorialViewModel.firstNameErrorText!,
                        onChanged: (String value) {
                          tutorialViewModel.validateFirstName(value!);
                        },
                      ),
                      SizedBox(height: 20.px),
                      TextFormsField(
                        keyboardType: TextInputType.text,
                        title: 'lastName'.tr(),
                        validate: tutorialViewModel.lastNameValid,
                        controller: tutorialViewModel.lastNameController,
                        hintText: 'enterYourLastName'.tr(),
                        errorText: tutorialViewModel.lastNameErrorText!,
                        onChanged: (String value) {
                          tutorialViewModel.validateLastName(value!);
                        },
                      ),
                      SizedBox(height: 20.px),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                            'makeItVisible'.tr(),
                            fontSize: 14.px,
                          ),
                          SizedBox(width: 10.px),
                          AppSwitch(
                            isActive: tutorialViewModel.isActiveSwitch,
                            onTap: () => tutorialViewModel.onTapSwitch,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: PreLoginCommonButton(
                  title: 'continue'.tr(),
                  onTap: () => tutorialViewModel.onTapSubmitUserInfo(),
                  isDisable: tutorialViewModel.isDisableUserInfoSubmit()),
            );
          });
        });
  }
}
