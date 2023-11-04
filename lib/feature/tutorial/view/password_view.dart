import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/app_textformfield/app_field.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/tutorial_view_model.dart';

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
              body: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 50.px),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.px),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AppImageAsset(
                              image: ImageConstants.backIcon,
                              height: 25.px,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.px),
                      Expanded(
                        child: ListView(
                          physics: const PageScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 15.px),
                          children: [
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.px),
                        child: AppButton(
                          height: 45.px,
                          borderRadius: BorderRadius.circular(10.px),
                          borderColor: AppColors.appBlue,
                          title: 'Continue',
                          onPressed: () {
                            // AppRouter.push(const SelectProfileView());
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30.px,
                      ),
                    ],
                  ),
                  const AppImageAsset(
                    image: ImageConstants.splashBG,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            );
          });
        });
  }
}
