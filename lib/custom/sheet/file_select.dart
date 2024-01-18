
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../../product/utils/typography.dart';
import '../image/app_image_assets.dart';

class ProfileList {
  ProfileList({required this.text, required this.icon});
  final String text;
  final String icon;
}
List<ProfileList> profileListData = <ProfileList>[
  ProfileList(text: 'Take Photo', icon: ImageConstants.camera),
  ProfileList(text: 'Add Image', icon: ImageConstants.pictureSquare),
  ProfileList(text: 'Add File', icon: ImageConstants.attach),
];
Widget fileSelect( {required Function(int) onTap} ){
  return   Padding(
    padding: const EdgeInsets.only(top: 15, bottom: 20),
    child: ListView.builder(
      itemCount: profileListData.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final ProfileList data =
        profileListData[index];
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          AppImageAsset(
                            image: data.icon,
                            height: 35.px,
                            width: 35.px,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 15),
                            child: Text(
                              data.text,
                              style: openSans.w400.get16.black,
                            ),
                          )
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.downArrowColor
                            .withOpacity(0.5),
                        size: 15,
                        weight: 80,
                      )
                    ]),
                onTap: () => onTap(index),
              ),
            ),
            Divider(
              color: AppColors.appBorderColor.withOpacity(0.5),
              thickness: 1,
              height: 30,
            )
          ],
        );
      },
    ),
  );
}
