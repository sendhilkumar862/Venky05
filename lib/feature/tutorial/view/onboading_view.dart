import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../config/routes/app_router.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appBarOnBoard.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/tutorial_view_model.dart';
import 'join_app_view.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

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
            return Scaffold(backgroundColor: AppColors.appWhite,
              appBar: AppBarOnBoard(),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.px),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40.px,
                    ),
                    SizedBox(
                      height: 390.px,
                      child: PageView.builder(
                        physics: BouncingScrollPhysics(),
                        controller: tutorialViewModel.pageController,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.px),
                            child: Column(
                              children: <Widget>[
                                Lottie.asset(
                                  tutorialViewModel.onboardingAnimation[index],
                                ),
                                AppText(
                                  tutorialViewModel.onboardingTitle[index],
                                  textAlign: TextAlign.center,
                                  fontSize: 24.px,
                                  fontWeight: FontWeight.w800,
                                ),
                                SizedBox(
                                  height: 10.px,
                                ),
                                AppText(
                                  tutorialViewModel.onboardingSubtitle[index],
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.appGrey,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 18.px),
                    SmoothPageIndicator(
                      controller: tutorialViewModel.pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                          spacing: 8.px,
                          radius: 10.px,
                          dotWidth: 10.px,
                          dotHeight: 8.px,
                          //paintStyle: PaintingStyle.stroke,
                          dotColor: AppColors.lightPurple,
                          activeDotColor: AppColors.appBlue),
                    ),
                    SizedBox(
                      height: 25.px,
                    ),
                    const Spacer(),
                    AppButton(
                      height: 45.px,
                      borderRadius: BorderRadius.circular(10.px),
                      borderColor: AppColors.appBlue,
                      title: 'Join To Hessah',
                      onPressed: () {
                        AppRouter.push(const JoinAppView());
                      },
                    ),
                    SizedBox(height: 15.px),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.px),
                      child: AppText(
                        'Login',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.px,
                        color: AppColors.appBlue,
                      ),
                    ),
                    SizedBox(
                      height: 30.px,
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}
