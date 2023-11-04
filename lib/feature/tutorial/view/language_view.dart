import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hessah/feature/tutorial/view/select_profile_view.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/app_router.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/divider/divider.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/tutorial_view_model.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

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
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.px),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 80.px),
                    Lottie.asset(ImageConstants.globe, height: 210.px),
                    SizedBox(
                      height: 15.px,
                    ),
                    AppText(
                      'Choose your Country and Language',
                      textAlign: TextAlign.center,
                      fontSize: 24.px,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(
                      height: 25.px,
                    ),
                    selectCardView(
                      icon: ImageConstants.countryIcon,
                      title: 'Kuwait',
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return CountryBottomSheet(
                              tutorialViewModel: tutorialViewModel,
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 15.px),
                    selectCardView(
                      icon: ImageConstants.usIcon,
                      title: 'English',
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return LanguageBottomSheet(
                              tutorialViewModel: tutorialViewModel,
                            );
                          },
                        );
                      },
                    ),
                    const Spacer(),
                    AppButton(
                      height: 45.px,
                      borderRadius: BorderRadius.circular(10.px),
                      borderColor: AppColors.appBlue,
                      title: 'Continue',
                      onPressed: () {
                        AppRouter.push(const SelectProfileView());
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

  Widget selectCardView({String? icon, String? title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 12.px),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.px),
          border: Border.all(color: AppColors.lightPurple, width: 1.5.px),
        ),
        child: Row(
          children: <Widget>[
            AppImageAsset(
              image: icon!,
              height: 20.px,
            ),
            SizedBox(
              width: 12.px,
            ),
            AppText(
              title ?? '',
              fontWeight: FontWeight.w400,
            ),
            const Spacer(),
            AppImageAsset(
              image: ImageConstants.downIcon,
              height: 20.px,
              color: AppColors.appGrey,
            ),
          ],
        ),
      ),
    );
  }
}

class CountryBottomSheet extends StatelessWidget {
  CountryBottomSheet({this.tutorialViewModel, super.key});

  TutorialViewModel? tutorialViewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height * 0.65).px,
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.px),
          topRight: Radius.circular(30.px),
        ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(top: 14.px, right: 15.px),
              alignment: Alignment.center,
              height: 25.px,
              width: 25.px,
              decoration: const BoxDecoration(
                  color: AppColors.appLightGrey, shape: BoxShape.circle),
              child: AppImageAsset(
                image: ImageConstants.closeIcon,
                height: 20.px,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 25.px,
              ),
              AppText('Change Country',
                  fontWeight: FontWeight.w700, fontSize: 14.px),
              SizedBox(
                height: 30.px,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: tutorialViewModel!.countries.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        tutorialViewModel!.selectCountry(index);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.px),
                        padding: EdgeInsets.symmetric(vertical: 8.px),
                        child: Row(
                          children: <Widget>[
                            AppImageAsset(
                              image: tutorialViewModel!.countryLogo[index],
                              height: 20.px,
                            ),
                            SizedBox(
                              width: 10.px,
                            ),
                            AppText(
                              tutorialViewModel!.countries[index],
                              fontWeight: FontWeight.w400,
                            ),
                            const Spacer(),
                            AppImageAsset(
                              image: ImageConstants.acceptedStatus,
                              height: 23.px,
                              color: (tutorialViewModel!.selectedIndex == index)
                                  ? AppColors.appBlue
                                  : AppColors.appWhite,
                            ),
                            SizedBox(
                              width: 5.px,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.px),
                      child: AppDivider(),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class LanguageBottomSheet extends StatelessWidget {
  LanguageBottomSheet({this.tutorialViewModel, super.key});

  TutorialViewModel? tutorialViewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height * 0.30).px,
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.px),
          topRight: Radius.circular(30.px),
        ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(top: 14.px, right: 15.px),
              alignment: Alignment.center,
              height: 25.px,
              width: 25.px,
              decoration: const BoxDecoration(
                  color: AppColors.appLightGrey, shape: BoxShape.circle),
              child: AppImageAsset(
                image: ImageConstants.closeIcon,
                height: 20.px,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 25.px,
              ),
              AppText('Change Language',
                  fontWeight: FontWeight.w700, fontSize: 14.px),
              SizedBox(
                height: 30.px,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: tutorialViewModel!.languages.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        tutorialViewModel!.selectLanguage(index);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.px),
                        padding: EdgeInsets.symmetric(vertical: 8.px),
                        child: Row(
                          children: <Widget>[
                            AppImageAsset(
                              image:tutorialViewModel!.languageIcon[index],
                              height: 20.px,
                            ),
                            SizedBox(
                              width: 10.px,
                            ),
                            AppText(
                              tutorialViewModel!.languages[index],
                              fontWeight: FontWeight.w400,
                            ),
                            const Spacer(),
                            AppImageAsset(
                              image: ImageConstants.acceptedStatus,
                              height: 23.px,
                              color: (tutorialViewModel!.selectedIndex == index)
                                  ? AppColors.appBlue
                                  : AppColors.appWhite,
                            ),
                            SizedBox(
                              width: 5.px,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.px),
                      child: AppDivider(),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
