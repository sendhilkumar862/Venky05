
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/preLoginWidget/pre_login_widget.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../view/bottomSheets/country_bottom_sheet.dart';
import '../../view/bottomSheets/language_bottom_sheet.dart';

import '../controller/language_controller.dart';


class LanguageView extends StatelessWidget {
   LanguageView({super.key});

  final LanguageController _languageController=Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Scaffold(
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
                  'Choose Language',
                  textAlign: TextAlign.center,
                  fontSize: 24.px,
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(
                  height: 25.px,
                ),
                selectCardView(
                  icon: _languageController.selectedCountry.value?.flag_url,
                  title: _languageController.selectedCountry.value?.name,
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
                              setState: setState, );
                          },
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 15.px),
                selectCardView(
                  icon: _languageController.languageIcon[_languageController.languageIndex.value],
                  title:_languageController.languages[_languageController.languageIndex.value],
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
                            return LanguageBottomSheet(setState: setState);
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
          onTap: _languageController.onPressedContinue,
          title: 'continue',
          isDisable: _languageController.selectedCountry == null,
        ),
      ),
    );
    // return BaseView<LanguageViewModel>(
    //     viewModel: LanguageViewModel(),
    //     onModelReady: (LanguageViewModel languageViewModel, WidgetRef ref) {
    //       languageViewModel.init();
    //       languageViewModel.setContext(context);
    //       languageViewModel.setRef(ref);
    //
    //     },
    //     onPageBuilder: (BuildContext context, LanguageViewModel languageViewModel, WidgetRef ref) {
    //        languageViewModel.fetchData();
    //       return Observer(
    //           warnWhenNoObservables: false,
    //           builder: (BuildContext context) {
    //             return Scaffold(
    //               body: SingleChildScrollView(
    //                 child: Padding(
    //                   padding: EdgeInsets.symmetric(horizontal: 15.px),
    //                   child: Column(
    //                     children: <Widget>[
    //                       SizedBox(height: 80.px),
    //                       Lottie.asset(ImageConstants.globe, height: 210.px),
    //                       SizedBox(
    //                         height: 15.px,
    //                       ),
    //                       AppText(
    //                         'chooseLang'.tr(),
    //                         textAlign: TextAlign.center,
    //                         fontSize: 24.px,
    //                         fontWeight: FontWeight.w800,
    //                       ),
    //                       SizedBox(
    //                         height: 25.px,
    //                       ),
    //                       selectCardView(
    //                         icon: languageViewModel.selectedCountry?.flag_url,
    //                         title: languageViewModel.selectedCountry?.name,
    //                         onTap: () {
    //                           showModalBottomSheet(
    //                             isScrollControlled: true,
    //                             context: context,
    //                             shape: const RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.vertical(
    //                                 top: Radius.circular(25.0),
    //                               ),
    //                             ),
    //                             builder: (BuildContext context) {
    //                               return StatefulBuilder(
    //                                 builder: (BuildContext context, setState) {
    //                                   return CountryBottomsSheet(
    //                                       setState: setState, );
    //                                 },
    //                               );
    //                             },
    //                           );
    //                         },
    //                       ),
    //                       SizedBox(height: 15.px),
    //                       selectCardView(
    //                         icon: languageViewModel.languageIcon[languageViewModel.languageIndex],
    //                         title: languageViewModel.languages[languageViewModel.languageIndex],
    //                         onTap: () {
    //                           showModalBottomSheet(
    //                             isScrollControlled: true,
    //                             context: context,
    //                             shape: const RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.vertical(
    //                                 top: Radius.circular(25.0),
    //                               ),
    //                             ),
    //                             builder: (BuildContext context) {
    //                               return StatefulBuilder(
    //                                 builder: (BuildContext context, setState) {
    //                                   return LanguageBottomSheet(setState: setState);
    //                                 },
    //                               );
    //                             },
    //                           );
    //                         },
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               bottomNavigationBar: PreLoginCommonButton(
    //                 onTap: languageViewModel.onPressedContinue,
    //                 title: 'continue'.tr(),
    //                 isDisable: languageViewModel.selectedCountry == null,
    //               ),
    //             );
    //           });
    //     });
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
