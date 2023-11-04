import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';

class StudentBottomSheet extends StatelessWidget {
  const StudentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height * 0.92).px,
      decoration: BoxDecoration(
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
              decoration: BoxDecoration(
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
              AppText('Students',
                  fontWeight: FontWeight.w700, fontSize: 14.px),
              SizedBox(
                height: 30.px,
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15.px),
                  physics: BouncingScrollPhysics(),
                  itemCount: 8,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.px,
                      mainAxisSpacing: 10.px,
                      childAspectRatio: 0.7),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(10.px),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.px),
                        border: Border.all(color: AppColors.appLightGrey),
                      ),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                          AppImageAsset(
                              image: ImageConstants.removeBookmark,
                              height: 18.px),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 8.px,
                              ),
                              AppImageAsset(
                                image: ImageConstants.avtar,
                                height: 55.px,
                              ),
                              SizedBox(
                                height: 6.px,
                              ),
                              AppText(
                                'User Name',
                                fontWeight: FontWeight.w700,
                                fontSize: 12.px,
                              ),
                              SizedBox(
                                height: 4.px,
                              ),
                              AppText(
                                'Grade 1 - 2 - 3',
                                fontSize: 12.px,
                              ),
                              SizedBox(
                                height: 10.px,
                              ),
                              AppButton(
                                title: 'Accept',
                                height: 45.px,
                                borderColor: AppColors.appBlue,
                                borderRadius: BorderRadius.circular(10.px),
                                onPressed: () {},
                              ),
                              SizedBox(height: 10.px),
                              AppText(
                                'Reject',
                                fontSize: 14.px,
                                color: AppColors.appLightRed,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.px),
                child: AppButton(
                  title: 'Accept All Students',
                  height: 45.px,
                  borderRadius: BorderRadius.circular(10.px),
                  borderColor: AppColors.appBlue,
                  onPressed: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
