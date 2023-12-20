
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:hessah/feature/tutorial/language/controller/language_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/divider/divider.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../language/viewModel/language_view_model.dart';

class CountryBottomsSheet extends StatelessWidget {
  CountryBottomsSheet({ super.key, this.setState});

  Function? setState;
  final LanguageController _languageController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(()
      => Container(
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
                AppText('Change Country', fontWeight: FontWeight.w700, fontSize: 14.px),
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
                    controller: _languageController.countryController.value,
                    hintText: 'Search',
                    onChanged: (String value) {
                      _languageController.filterCountries(value, setState!);
                    },
                  ),
                ),
                SizedBox(
                  height: 15.px,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _languageController.countries.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async{
                         await _languageController.selectCountry(_languageController.countries[index]);
                          Navigator.pop(context);
                        },
                        child: Container(
                          color: AppColors.appTransparent,
                          margin: EdgeInsets.symmetric(horizontal: 15.px),
                          padding: EdgeInsets.symmetric(vertical: 8.px),
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: AppImageAsset(
                                  image: _languageController.countries[index].flag_url!,
                                  fit: BoxFit.fill,
                                  height: 25.px,
                                  width: 25.px,
                                ),
                              ),
                              SizedBox(
                                width: 10.px,
                              ),
                              Expanded(
                                child: AppText(
                                  _languageController.countries[index].name!,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Spacer(),
                              AppImageAsset(
                                image: ImageConstants.acceptedStatus,
                                height: 23.px,
                                color:
                                    (_languageController.selectedCountry.value?.name == _languageController.countries[index].name)
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
      ),
    );
  }
}
