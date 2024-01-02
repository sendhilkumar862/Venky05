
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/route.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/cardView/warning_card_view.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../controller/email_enter_controller.dart';


class EmailView extends StatelessWidget {
   EmailView({super.key});
  final EmailEnterController _emailEnterController=Get.put(EmailEnterController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: PreLoginCustomBody(
          widget: Expanded(
            child: ListView(
              physics: const PageScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 15.px),
              children: <Widget>[
                SizedBox(height: 10.px),
                SafeArea(bottom: false, child: OnTapBack()),
                SizedBox(height: 110.px),
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
                  'join'.tr,
                  fontSize: 24.px,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 20.px),
                TextFormsField(
                  title: 'emailAdd'.tr,
                  validate: _emailEnterController.emailValid.value,
                  controller: _emailEnterController.emailController,
                  hintText: 'enterEmail'.tr,
                  errorText: _emailEnterController.emailErrorText.value,
                  onChanged: (String value) {
                    _emailEnterController.validateEmail(value);
                  },
                ),
                SizedBox(
                  height: 25.px,
                ),
                if (_emailEnterController.registerWarning.value)
                  WarningCardView(
                      color: AppColors.lightPurple,
                      error: _emailEnterController.registerWarningMessage.value),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            PreLoginCommonButton(
              title: 'continue'.tr,
              onTap: () => _emailEnterController.onTapEmailSubmit(),
              height: 0,
              isDisable: _emailEnterController.emailValid.value != 1,
            ),
            SizedBox(height: 15.px),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.loginView),
              child: AppText(
                'alreadyLogin'.tr,
                fontSize: 14.px,
                fontWeight: FontWeight.w600,
                color: AppColors.appBlue,
              ),
            ),
            SizedBox(
              height: 40.px,
            ),
          ],
        ),
      );
    });
  }
}
