import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/app_router.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appBarOnBoard.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/tutorial_view_model.dart';
import 'onboading_view.dart';

class ProfileSelectionView extends StatelessWidget {
  const ProfileSelectionView({super.key});

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
              backgroundColor: AppColors.appWhite,
              appBar: AppBarOnBoard(),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.px),
                child: Column(
                  children: [
                    SizedBox(height: 80.px),
                    Lottie.asset(ImageConstants.profileManager, height: 210.px),
                    SizedBox(
                      height: 15.px,
                    ),
                    AppText(
                      'Select Your Profile',
                      textAlign: TextAlign.center,
                      fontSize: 24.px,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(
                      height: 25.px,
                    ),
                    Row(
                      children: List.generate(
                        2,
                        (index) => selectCardView(
                          icon: ImageConstants.graduateIcon,
                          title: tutorialViewModel.profileItems[index],
                          tutorialViewModel: tutorialViewModel,
                          index: index,
                          onTap: () => tutorialViewModel.selectedItems(index),
                        ),
                      ),
                    ),
                    const Spacer(),
                    AppButton(
                      height: 45.px,
                      borderRadius: BorderRadius.circular(10.px),
                      borderColor: AppColors.appBlue,
                      title: 'Continue',
                      onPressed: () {
                        AppRouter.push(const OnBoardingView());
                      },
                    ),
                    SizedBox(
                      height: 20.px,
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget selectCardView(
      {String? icon,
      String? title,
      VoidCallback? onTap,
      TutorialViewModel? tutorialViewModel,
      int? index}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.px),
          height: 88.px,
          padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 12.px),
          decoration: BoxDecoration(
            color: index == tutorialViewModel!.selectedIndex
                ? AppColors.appBlue
                : AppColors.white,
            borderRadius: BorderRadius.circular(12.px),
            border: Border.all(
                color: index == tutorialViewModel!.selectedIndex
                    ? AppColors.appBlue
                    : AppColors.lightPurple,
                width: 1.5.px),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppImageAsset(
                image: icon!,
                height: 25.px,
                color: index != tutorialViewModel!.selectedIndex
                    ? AppColors.appDarkBlack
                    : AppColors.white,
              ),
              SizedBox(
                width: 12.px,
              ),
              AppText(
                title ?? '',
                fontWeight: FontWeight.w400,
                color: index != tutorialViewModel!.selectedIndex
                    ? AppColors.appDarkBlack
                    : AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
