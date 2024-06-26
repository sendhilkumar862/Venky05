import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/app_textformfield/text_field.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/validators.dart';
import '../viewModel/tutorial_view_model.dart';
import 'email_view_model.dart';

class EmailView extends StatelessWidget {
  const EmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<EmailViewModel>(
        viewModel: EmailViewModel(),
        onModelReady: (EmailViewModel emailViewModel) {
          emailViewModel.setContext(context);
        },
        onPageBuilder:
            (BuildContext context, EmailViewModel emailViewModel) {
          return Observer(builder: (BuildContext context) {
            return Scaffold(
              body: PreLoginCustomBody(
                widget: Expanded(
                  child: ListView(
                    physics: PageScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 15.px),
                    children: <Widget>[
                      SizedBox(height: 35.px),
                      const OnTapBack(),
                      SizedBox(height: 80.px),
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
                        'join'.tr(),
                        fontSize: 24.px,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 10.px),
                      TextFormsField(
                        title: 'emailAdd'.tr(),
                        validate: emailViewModel.emailValid,
                        controller: emailViewModel.emailController,
                        hintText: 'enterEmail'.tr(),
                        errorText: emailViewModel.emailErrorText!,
                        onChanged: (String value) {
                          emailViewModel.validateEmail(value!);
                        },
                      ),
                      SizedBox(
                        height: 20.px,
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  PreLoginCommonButton(
                    title: 'continue'.tr(),
                    onTap: () => emailViewModel.onTapEmailSubmit(),
                    height: 0,
                    isDisable: emailViewModel.emailValid != 1,
                  ),
                  SizedBox(height: 15.px),
                  AppText(
                    'alreadyLogin'.tr(),
                    fontSize: 14.px,
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBlue,
                  ),
                  SizedBox(
                    height: 40.px,
                  ),
                ],
              ),
            );
          });
        });
  }
}
