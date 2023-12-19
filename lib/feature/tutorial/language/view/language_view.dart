
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';

import '../../../../product/network/all_providers.dart';
import '../../view/bottomSheets/country_bottom_sheet.dart';
import '../../view/bottomSheets/language_bottom_sheet.dart';

import '../viewModel/language_view_model.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LanguageViewModel>(
        viewModel: LanguageViewModel(),
        onModelReady: (LanguageViewModel languageViewModel, WidgetRef ref) {
          languageViewModel.init();
          languageViewModel.setContext(context);
          languageViewModel.setRef(ref);
         
        },
        onPageBuilder: (BuildContext context, LanguageViewModel languageViewModel, WidgetRef ref) {
           languageViewModel.fetchData();
          return Observer(
              warnWhenNoObservables: false,
              builder: (BuildContext context) {
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.px),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 80.px),
                          Lottie.asset(ImageConstants.globe, height: 210.px),
                          SizedBox(
                            height: 15.px,
                          ),
                          AppText(
                            'chooseLang'.tr,
                            textAlign: TextAlign.center,
                            fontSize: 24.px,
                            fontWeight: FontWeight.w800,
                          ),
                          SizedBox(
                            height: 25.px,
                          ),
                          selectCardView(
                            icon: languageViewModel.selectedCountry?.flag_url,
                            title: languageViewModel.selectedCountry?.name,
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
                                          setState: setState, languageViewModel: languageViewModel);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: 15.px),
                          selectCardView(
                            icon: languageViewModel.languageIcon[languageViewModel.languageIndex],
                            title: languageViewModel.languages[languageViewModel.languageIndex],
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
                                          languageViewModel: languageViewModel, setState: setState);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: PreLoginCommonButton(
                    onTap: languageViewModel.onPressedContinue,
                    title: 'continue'.tr,
                    isDisable: languageViewModel.selectedCountry == null,
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
              borderRadius: BorderRadius.circular(500),
              child: AppImageAsset(
                fit: BoxFit.fill,
                image: icon ?? ImageConstants.globe,
                height: 20.px,
                width: 20.px,
              ),
            ),
            SizedBox(
              width: 12.px,
            ),
            Expanded(
              child: AppText(
                title ?? 'Select',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: 12.px,
            ),
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
