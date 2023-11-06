import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/divider/divider.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../viewModel/tutorial_view_model.dart';

class CountryBottomSheet extends StatelessWidget {
  CountryBottomSheet({this.tutorialViewModel, this.setState, super.key});

  TutorialViewModel? tutorialViewModel;
  Function? setState;

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
                        setState!(() {});
                      },
                      child: Container(color: AppColors.appWhite,
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
