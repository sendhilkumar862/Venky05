import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/divider/divider.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/validators.dart';
import '../../mobileEnter/model/country_code_model.dart';
import '../../mobileEnter/viewModel/mobile_view_model.dart';

class CountryCodeBottomsSheet extends StatelessWidget {
  CountryCodeBottomsSheet({this.mobileViewModel, super.key, this.setState});

  MobileViewModel? mobileViewModel;
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
              AppText('Country Code',
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
                  controller: mobileViewModel!.countryController,
                  hintText: 'Search',
                  onChanged: (String value) {
                    mobileViewModel!.filterCountries(value, setState!);
                  },
                ),
              ),
              SizedBox(
                height: 15.px,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: mobileViewModel!.filteredCountries.isNotEmpty
                      ? mobileViewModel!.filteredCountries.length
                      : mobileViewModel!.countries.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        final CountryCodeModel countryCodeModel =
                            mobileViewModel!.filteredCountries.isNotEmpty
                                ? mobileViewModel!.filteredCountries[index]
                                : mobileViewModel!.countries[index];
                        logs(
                            'Selected country --> ${countryCodeModel.toJson()}');
                        // final int selectedIndex = mobileViewModel!.countries.indexOf(countryCodeModel);
                        mobileViewModel!.selectedCountry = countryCodeModel;
                        mobileViewModel!.selectedCountryCode =
                            countryCodeModel.idd_code ?? '';
                        // logs('Selected index --> $selectedIndex');
                        setState!(
                          () {
                            mobileViewModel?.filteredCountries.clear();
                            // mobileViewModel!.selectCountry(selectedIndex);
                            Future.delayed(
                              const Duration(milliseconds: 200),
                              () => AppRouter.pop(),
                            );
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
                                image: mobileViewModel!
                                        .filteredCountries.isNotEmpty
                                    ? mobileViewModel!
                                        .filteredCountries[index].flag_url!
                                    : mobileViewModel!
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
                              mobileViewModel!.filteredCountries.isNotEmpty
                                  ? mobileViewModel!
                                      .filteredCountries[index].idd_code!
                                  : mobileViewModel!.countries[index].idd_code!,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 6.px),
                            AppText(
                              mobileViewModel!.filteredCountries.isNotEmpty
                                  ? mobileViewModel!
                                      .filteredCountries[index].name!
                                  : mobileViewModel!.countries[index].name!,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                            ),
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
