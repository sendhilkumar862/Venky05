import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../app_textformfield/text_field.dart';
import '../divider/divider.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class CountryBottomSheet extends StatelessWidget {
  CountryBottomSheet(
      {this.countries, this.selectedIndex, required this.onTap, super.key});

  List<String>? countries = [];
  int? selectedIndex;
  Function(int) onTap;

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
                height: 10.px,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.px),
                  child: TextFormsField(
                      controller: TextEditingController(), hintText: 'Search')),
              SizedBox(
                height: 15.px,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: countries!.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        onTap(index);
                      },
                      child: Container(
                        color: AppColors.appWhite,
                        margin: EdgeInsets.symmetric(horizontal: 15.px),
                        padding: EdgeInsets.symmetric(vertical: 8.px),
                        child: Row(
                          children: <Widget>[
                            AppImageAsset(
                              image: ImageConstants.oman,
                              height: 20.px,
                            ),
                            SizedBox(
                              width: 10.px,
                            ),
                            AppText(
                              countries?[index] ?? '',
                              fontWeight: FontWeight.w400,
                            ),
                            const Spacer(),
                            AppImageAsset(
                              image: ImageConstants.acceptedStatus,
                              height: 23.px,
                              color: (selectedIndex == index)
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
