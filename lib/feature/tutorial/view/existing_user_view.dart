import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/tutorial_view_model.dart';

class ExistingUserView extends StatelessWidget {
  const ExistingUserView({super.key});

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
                    onTap: () => AppRouter.pushNamed(Routes.mobileView),
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
          });
        });
  }
}
