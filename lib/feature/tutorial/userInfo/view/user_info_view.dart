
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/switch/app_switch.dart';
import '../../../../custom/text/app_text.dart';
import '../controller/user_info_controller.dart';


class UserInfoView extends StatelessWidget {
   UserInfoView({super.key});
  final UserInfoController _userInfoController = Get.put(UserInfoController());
  @override
  Widget build(BuildContext context) {
    _userInfoController.data=Get.arguments;
    return Obx(() {
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
                        onTapBack:
                        (_userInfoController.currentProfile.value == 'Tutor')
                            ? () {
                          int count = 0;
                          Navigator.popUntil(context, (Route route) {
                            return count++ == 2;
                          });
                        }
                            : () {
                          Get.back();
                        })),
                SizedBox(height: 180.px),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    textAlign: TextAlign.start,
                    'userInfo'.tr,
                    fontSize: 24.px,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20.px),
                TextFormsField(
                  keyboardType: TextInputType.text,
                  title: 'firstName'.tr,
                  validate: _userInfoController.firstNameValid.value,
                  controller: _userInfoController.firstNameController,
                  hintText: 'enterYourFirstName'.tr,
                  errorText: _userInfoController.firstNameErrorText.value,
                  onChanged: (String value) {
                    _userInfoController.validateFirstName(value!);
                  },
                ),
                SizedBox(height: 20.px),
                TextFormsField(
                  keyboardType: TextInputType.text,
                  title: 'lastName'.tr,
                  validate: _userInfoController.lastNameValid.value,
                  controller: _userInfoController.lastNameController,
                  hintText: 'enterYourLastName'.tr,
                  errorText: _userInfoController.lastNameErrorText.value,
                  onChanged: (String value) {
                    _userInfoController.validateLastName(value!);
                  },
                ),
                SizedBox(height: 20.px),
                if (_userInfoController.currentProfile.value == 'Tutor')
                  Row(
                    children: <Widget>[
                      AppText(
                        'makeItVisible'.tr,
                        fontSize: 14.px,
                      ),
                      SizedBox(width: 10.px),
                      AppSwitch(
                        isActive: _userInfoController.isActiveSwitch.value,
                        onTap: () => _userInfoController.onTapSwitch(),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
        bottomNavigationBar: PreLoginCommonButton(
            title: 'continue'.tr,
            onTap: () => _userInfoController.onTapSubmitUserInfo(),
            isDisable: _userInfoController.isDisableUserInfoSubmit()),
      );
    });
  }
}
