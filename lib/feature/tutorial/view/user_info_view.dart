import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/preLoginWidget/pre_login_widget.dart';
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
                          'User Information',
                          fontSize: 24.px,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20.px),
                      const AppTextFormField(
                        title: 'First Name',
                        hintText: 'Enter your first name',
                        fillColor: AppColors.appWhite,
                      ),
                      const AppTextFormField(
                        title: 'Last Name',
                        hintText: 'Enter your last name',
                        fillColor: AppColors.appWhite,
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: PreLoginCommonButton(
                title: 'Continue',
                onTap: () => AppRouter.pushNamed(Routes.passwordView),
              ),
            );
          });
        });
  }
}
