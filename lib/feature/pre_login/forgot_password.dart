import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../config/routes/app_router.dart';
import '../../config/routes/routes.dart';
import '../../custom/app_button/app_button.dart';
import '../../custom/app_textformfield/app_field.dart';
import '../../custom/appbar/appbar.dart';
import '../../product/utils/typography.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        isBack: true,
        isTitleOnly: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/icons/primary_logo_color.png'),
            Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  'forgotPassword!'.tr(),
                  style: openSans.get24.w700.appTextColor,
                )),
            AppTextFormField(
              title: 'emailAddress'.tr(),
              hintText: 'enterYourEmailAddress'.tr(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: AppButton(
                title: 'resetPassword'.tr(),
                onPressed: () {},
                isDisable: true,
              ),
            ),
            Center(
                child: TextButton(
                    onPressed: () {
                      AppRouter.pushNamed(Routes.personalInfo);
                    },
                    child: Text(
                      'logIn'.tr(),
                      style: openSans.get14.w600,
                    )))
          ],
        ),
      ),
    );
  }
}
