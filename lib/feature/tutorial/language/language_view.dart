import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/app_router.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../view/bottomSheets/country_bottom_sheet.dart';
import '../view/bottomSheets/language_bottom_sheet.dart';
import '../view/profile_selection_view.dart';
import 'language_repository.dart';
import 'language_view_model.dart';

class LanguageView extends ConsumerWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  //  final ProviderContainer container = ProviderContainer();

    return BaseView<LanguageViewModel>(
        viewModel: LanguageViewModel(ref as Ref<Object?>),
        onModelReady: (LanguageViewModel languageViewModel) {
          languageViewModel.setContext(context);
          languageViewModel.init();
        },
        onPageBuilder:
            (BuildContext context, LanguageViewModel languageViewModel) {
          return Observer(
              warnWhenNoObservables: false,
              builder: (BuildContext context) {
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
                          icon: languageViewModel
                              .filteredCountries.isNotEmpty? languageViewModel.filteredCountries[languageViewModel.countryIndex].flag_url 
                              : languageViewModel.countries[languageViewModel.countryIndex].flag_url,
                          title: languageViewModel.filteredCountries.isNotEmpty? languageViewModel.filteredCountries[languageViewModel.countryIndex].name
                              : languageViewModel.countries[languageViewModel.countryIndex].name,
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
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(700),
              child: AppImageAsset(
                image: icon!,
                height: 20.px,
                width: 20.px,
              ),
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
