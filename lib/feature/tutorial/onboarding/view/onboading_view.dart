
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hessah/product/network/local/key_value_storage_base.dart';
import 'package:hessah/product/network/local/key_value_storage_service.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/appbar/appBarOnBoard.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../emailEnter/view/email_view.dart';
import '../viewModel/onboarding_view_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key, this.continueRegistration});
  final bool? continueRegistration;
  @override
  Widget build(BuildContext context) {
    return BaseView<OnboardingViewModel>(
        viewModel: OnboardingViewModel(),
        onModelReady: (OnboardingViewModel onboardingViewModel, WidgetRef ref) {
          onboardingViewModel.setContext(context);
          onboardingViewModel.init();
        },
        onPageBuilder:
            (BuildContext context, OnboardingViewModel onboardingViewModel, WidgetRef ref) {
          return Observer(builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: AppColors.appWhite,
              appBar: AppBarOnBoard(
                  title: 'exploreApp'.tr,
                  backNavigate: !(continueRegistration ?? false),
                  icon: ImageConstants.layersIcon,
                  onTap: () => AppRouter.pushNamed(Routes.HomeScreenRoute),
                  onBackTap: () {
                    final KeyValueStorageBase keyValueStorageBase =
                        KeyValueStorageBase();
                    keyValueStorageBase.setCommon(
                        KeyValueStorageService.profile, '');
                    AppRouter.pop(context);
                  }),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.px),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 400.px,
                      child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: onboardingViewModel.pageController,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.px),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: onboardingViewModel.currentProfile ==
                                          'Student'
                                      ? Lottie.asset(onboardingViewModel
                                          .studentAnimation[index])
                                      : Lottie.asset(onboardingViewModel
                                          .teacherAnimation[index]),
                                ),
                                AppText(
                                  (onboardingViewModel.currentProfile ==
                                          'Student')
                                      ? onboardingViewModel.studentTitle[index]
                                      : onboardingViewModel.teacherTitle[index],
                                  textAlign: TextAlign.center,
                                  fontSize: 24.px,
                                  fontWeight: FontWeight.w800,
                                ),
                                SizedBox(
                                  height: 10.px,
                                ),
                                AppText(
                                  (onboardingViewModel.currentProfile ==
                                          'Student')
                                      ? onboardingViewModel
                                          .studentSubtitle[index]
                                      : onboardingViewModel
                                          .teacherSubtitle[index],
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
                      controller: onboardingViewModel.pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                          spacing: 8.px,
                          radius: 10.px,
                          dotWidth: 8.px,
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
                      title: 'join'.tr,
                      isDisable: false,
                      onPressed: () {
                        AppRouter.push(const EmailView());
                      },
                    ),
                    SizedBox(height: 15.px),
                    GestureDetector(
                      onTap: () => AppRouter.pushNamed(Routes.loginView),
                      child: AppText(
                        'login'.tr,
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
