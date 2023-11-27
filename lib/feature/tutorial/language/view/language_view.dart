import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../profileSet/view/profile_selection_view.dart';
import '../../view/bottomSheets/country_bottom_sheet.dart';
import '../../view/bottomSheets/language_bottom_sheet.dart';
import '../viewModel/language_view_model.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LanguageViewModel>(
        viewModel: LanguageViewModel(),
        onModelReady: (LanguageViewModel languageViewModel) {
          languageViewModel.setContext(context);
          languageViewModel.init();
        },
        onPageBuilder:
            (BuildContext context, LanguageViewModel languageViewModel) {
          return Observer(
              warnWhenNoObservables: false,
              builder: (BuildContext context) {
                if (languageViewModel == null) {
                  return Container();
                }
                return Scaffold(
                  body: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 15.px),
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
                        icon: languageViewModel.filteredCountries.isNotEmpty
                            ? languageViewModel
                                .filteredCountries[
                                    languageViewModel.languageIndex]
                                .flag_url!
                            : languageViewModel
                                .countries[languageViewModel.languageIndex]
                                .flag_url!,
                        title: languageViewModel.filteredCountries.isNotEmpty
                            ? languageViewModel
                                .filteredCountries[
                                    languageViewModel.languageIndex]
                                .name!
                            : languageViewModel
                                .countries[languageViewModel.languageIndex]
                                .name!,
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context, setState) {
                                  return CountryBottomsSheet(
                                      setState: setState,
                                      languageViewModel: languageViewModel);
                                },
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 15.px),
                      selectCardView(
                        icon: languageViewModel
                            .languageIcon[languageViewModel.languageIndex],
                        title: languageViewModel
                            .languages[languageViewModel.languageIndex],
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context, setState) {
                                  return LanguageBottomSheet(
                                      languageViewModel: languageViewModel,
                                      setState: setState);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  bottomNavigationBar: PreLoginCommonButton(
                    onTap: () => AppRouter.push(const ProfileSelectionView()),
                    title: 'continue'.tr(),
                    isDisable: false,
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
            ClipOval(
              child: AppImageAsset(
                image: icon!,
                height: 20.px,
                width: 20.px,
              ),
            ),
            SizedBox(width: 12.px),
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
