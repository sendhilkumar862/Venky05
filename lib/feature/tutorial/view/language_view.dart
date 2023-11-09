import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hessah/feature/tutorial/view/profile_selection_view.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/app_router.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/sheet/country_bottom_sheet.dart';
import '../../../custom/sheet/language_bottom_sheet.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/cache/locale_manager.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../viewModel/tutorial_view_model.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  TextEditingController nationalityController = TextEditingController();
  int selectedIndex = -1;
  int selectedLanguege = -1;

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
                      'chooseLang'.tr(),
                      textAlign: TextAlign.center,
                      fontSize: 24.px,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(
                      height: 25.px,
                    ),
                    selectCardView(
                      icon: ImageConstants.countryIcon,
                      title: tutorialViewModel
                          .countries[tutorialViewModel.countryIndex],
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
                            return StatefulBuilder(
                              builder: (BuildContext context, setState) {
                                return Observer(builder: (_) {
                                  return CountryBottomSheet(
                                    countries: tutorialViewModel.countries,
                                    selectedIndex: selectedIndex,
                                    onTap: (int index) {},
                                  );
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 15.px),
                    selectCardView(
                      icon: tutorialViewModel
                          .languageIcon[tutorialViewModel.languageIndex],
                      title: tutorialViewModel
                          .languages[tutorialViewModel.languageIndex],
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
                            return StatefulBuilder(
                              builder: (BuildContext context, setState) {
                                return LanguageBottomSheet(
                                  tutorialViewModel: tutorialViewModel,
                                  setState: setState,
                                  onTap: (int index) {
                                    setState(() {
                                      setState(() {
                                        tutorialViewModel
                                            .selectedLanguageIndex = index;
                                        tutorialViewModel.selectLanguage(
                                            tutorialViewModel.languages[index]);
                                        LocaleManager.instance.setStringValue(
                                            LocaleManager.language,
                                            tutorialViewModel.languages[index]);
                                      });
                                    });
                                  },
                                );
                              },
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
                      title: 'continue'.tr(),
                      isDisable: false,
                      onPressed: () {
                        AppRouter.push(const ProfileSelectionView());
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
        height: 50.px,
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
              height: 16.px,
              color: AppColors.appGrey,
            ),
          ],
        ),
      ),
    );
  }
}
