import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/divider/divider.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/cache/locale_manager.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../language/language_view_model.dart';
import '../../viewModel/tutorial_view_model.dart';

class CountryBottomsSheet extends StatelessWidget {
  CountryBottomsSheet({this.languageViewModel, super.key, this.setState});

  LanguageViewModel? languageViewModel;
  Function? setState;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height * 0.80).px,
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
          GestureDetector(
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
                height: 10.px,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.px),
                child: TextFormsField(
                  prefix: Padding(
                    padding: EdgeInsets.only(left: 15.px),
                    child: AppImageAsset(
                      image: ImageConstants.searchIcon,
                      height: 20.px,
                      color: AppColors.appGrey,
                    ),
                  ),
                  controller: languageViewModel!.countryController,
                  hintText: 'Search',
                  onChanged: (String value) {
                    languageViewModel!.filterCountries(value, setState!);
                  },
                ),
              ),
              SizedBox(
                height: 15.px,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: languageViewModel!.filteredCountries.isNotEmpty
                      ? languageViewModel!.filteredCountries.length
                      : languageViewModel!.countries.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState!(
                          () {
                            languageViewModel!.selectCountry(index);
                          },
                        );
                      },
                      child: Container(
                        color: AppColors.appTransparent,
                        margin: EdgeInsets.symmetric(horizontal: 15.px),
                        padding: EdgeInsets.symmetric(vertical: 8.px),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(700),
                              child: AppImageAsset(
                                image: languageViewModel!
                                        .filteredCountries.isNotEmpty!
                                    ? languageViewModel!
                                        .filteredCountries[index].flag_url!
                                    : languageViewModel!
                                        .countries[index].flag_url!,
                                fit: BoxFit.fill,
                                height: 20.px,
                                width: 20,
                              ),
                            ),
                            SizedBox(
                              width: 10.px,
                            ),
                            AppText(
                              languageViewModel!.filteredCountries.isNotEmpty!
                                  ? languageViewModel!
                                      .filteredCountries[index].name!
                                  : languageViewModel!
                                      .countries[index].name!,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            AppImageAsset(
                              image: ImageConstants.acceptedStatus,
                              height: 23.px,
                              color: (languageViewModel!.countryIndex == index)
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
