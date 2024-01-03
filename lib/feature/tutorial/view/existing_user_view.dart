import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../config/routes/route.dart';

import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';



class ExistingUserView extends StatelessWidget {
  const ExistingUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PreLoginCustomBody(
        widget: Expanded(
          child: ListView(
            physics: PageScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 15.px),
            children: <Widget>[
              SizedBox(height: 35.px),
              OnTapBack(),
              SizedBox(height: 80.px),
              SizedBox(height: 28.px),
              AppText(
                textAlign: TextAlign.start,
                'Join To Hessah',
                fontSize: 24.px,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 10.px),
              AppTextFormField(
                // titleColor: (walletViewModel.nameError.isEmpty)
                //     ? AppColors.appGrey
                //     : ('valid' == walletViewModel.nameError)
                //     ? AppColors.appRed
                //     : AppColors.appBlue,
                //controller: tutorialViewModel.emailController,
                title: 'Email Address',
                keyboardType: TextInputType.text,
                hintText: 'Enter your email address',
                validate: (String? value) {
                  // return walletViewModel.nameValidation(value!);
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
        children: [
          PreLoginCommonButton(
            title: 'Continue',
            onTap: () => Get.toNamed(Routes.mobileView),
            height: 0,
          ),
          SizedBox(height: 15.px),
          AppText(
            'Already User? Login',
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
  }
}
