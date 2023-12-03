import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/divider/divider.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
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
              decoration: const BoxDecoration(color: AppColors.appLightGrey, shape: BoxShape.circle),
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
              AppText('Country Code', fontWeight: FontWeight.w700, fontSize: 14.px),
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
                    // ignore: avoid_dynamic_calls
                    setState!(() {});
                  },
                ),
              ),
              SizedBox(
                height: 15.px,
              ),
              Expanded(
                  child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState!(() {
                        mobileViewModel!.selectCountry(index);
                        Future.delayed(
                          const Duration(milliseconds: 200),
                          () => AppRouter.pop(),
                        );
                      });
                    },
                    child: Container(
                      color: AppColors.appTransparent,
                      margin: EdgeInsets.symmetric(horizontal: 15.px),
                      padding: EdgeInsets.symmetric(vertical: 8.px),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(borderRadius: BorderRadius.circular(700),
                            child: AppImageAsset(
                              image: mobileViewModel!.countries[index].flag_url?? ImageConstants.globe,
                              fit: BoxFit.fill,
                              height: 20.px,
                              width: 20,
                            ),
                          ),
                          SizedBox(width: 10),
                          AppText(
                            mobileViewModel!.countries[index].idd_code??'',
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 6.px),
                          AppText(
                            mobileViewModel!.countries[index].name??'',
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.px),
                    child: AppDivider(),
                  );
                },
                itemCount: mobileViewModel!.countries.length,
              ))
            ],
          )
        ],
      ),
    );
  }
}
