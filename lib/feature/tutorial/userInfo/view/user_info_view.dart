import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/switch/app_switch.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/utils/validators.dart';
import '../viewModel/user_info_view_model.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<UserInfoViewModel>(
        viewModel: UserInfoViewModel(),
        onModelReady: (UserInfoViewModel userInfoViewModel) {
          userInfoViewModel.setContext(context);
          userInfoViewModel.init();
          userInfoViewModel.data = ModalRoute.of(context)!.settings.arguments! as Map;
        },
        onPageBuilder: (BuildContext context, UserInfoViewModel userInfoViewModel) {
          return Observer(builder: (BuildContext context) {
            return Scaffold(
              body: PreLoginCustomBody(
                widget: Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 15.px),
                    children: <Widget>[
                      SizedBox(height: 10.px),
                      SafeArea(
                          bottom: false,
                          child: OnTapBack(
                              onTapBack: (userInfoViewModel.currentProfile == 'Tutor')
                                  ? () {
                                      int count = 0;
                                      Navigator.popUntil(context, (route) {
                                        return count++ == 2;
                                      });
                                    }
                                  : () {
                                      AppRouter.pop();
                                    })),
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
                        validate: userInfoViewModel.firstNameValid,
                        controller: userInfoViewModel.firstNameController,
                        hintText: 'enterYourFirstName'.tr(),
                        errorText: userInfoViewModel.firstNameErrorText!,
                        onChanged: (String value) {
                          userInfoViewModel.validateFirstName(value!);
                        },
                      ),
                      SizedBox(height: 20.px),
                      TextFormsField(
                        keyboardType: TextInputType.text,
                        title: 'lastName'.tr(),
                        validate: userInfoViewModel.lastNameValid,
                        controller: userInfoViewModel.lastNameController,
                        hintText: 'enterYourLastName'.tr(),
                        errorText: userInfoViewModel.lastNameErrorText!,
                        onChanged: (String value) {
                          userInfoViewModel.validateLastName(value!);
                        },
                      ),
                      SizedBox(height: 20.px),
                      if(userInfoViewModel.currentProfile=='Tutor')Row(
                        children: <Widget>[
                          AppText(
                            'makeItVisible'.tr(),
                            fontSize: 14.px,
                          ),
                          SizedBox(width: 10.px),
                          AppSwitch(
                            isActive: userInfoViewModel.isActiveSwitch,
                            onTap: () => userInfoViewModel.onTapSwitch(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: PreLoginCommonButton(
                  title: 'continue'.tr(),
                  onTap: () => userInfoViewModel.onTapSubmitUserInfo(),
                  isDisable: userInfoViewModel.isDisableUserInfoSubmit()),
            );
          });
        });
  }
}
