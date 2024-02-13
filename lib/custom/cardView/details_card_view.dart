import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../../product/extension/string_extension.dart';
import '../../product/utils/typography.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class DetailsCardView extends StatelessWidget {
  DetailsCardView({
    this.countryIcon,
    this.reViewLength,
    this.countryName,
    this.name,
    this.avatar,
    this.isPro,
    this.subjects,
    this.isBookmarked,
    this.cardMargin,
    this.boxShadow,
    super.key,
  });

  num? reViewLength;
  String? avatar;
  String? name;
  bool? isPro;
  bool? isBookmarked;
  String? countryIcon;
  String? countryName;
  String? subjects;
  EdgeInsetsGeometry? cardMargin;
  List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.px),
      margin:
          cardMargin ?? EdgeInsets.only(left: 15.px, top: 10.px, bottom: 27.px),
      width: 146.px,
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(13.px),
        border: Border.all(
          color: AppColors.appBorderColor.withOpacity(0.3),
          width: 1.2,
        ),
        boxShadow: boxShadow ?? AppColors.infoBoxShadow,
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8.px),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.appProfile,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset:
                        const Offset(0, 2), // changes the position of the shadow
                      ),
                    ],
                  ),
                  width: 50.px,
                  height: 50.px,
                  child: ClipOval(
                    child:  avatar==null?Center(
                        child: Text(
                            name!.extractInitials(),
                            style: openSans.get20.w700.white)): AppImageAsset(
                      image: avatar!.getImageUrl('profile'),
                      height: 40.px,
                    ),
                  ),
                ) ,
                SizedBox(
                  height: 20.px,
                  width: 50.px,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return AppImageAsset(
                        image: (index < reViewLength!)
                            ? ImageConstants.reviewStarPurple
                            : ImageConstants.reviewStar,
                        height: 10.px,
                        width: 10.px,
                      );
                    },
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Mr. ',
                        style: TextStyle(
                          color: AppColors.appDarkBlack,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.px,
                        ),
                      ),
                      TextSpan(
                        text: name ?? '',
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.appDarkBlack,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.px,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isPro ?? false)
                  SizedBox(
                    height: 4.px,
                  ),
                if (isPro ?? false)
                  Container(
                    width: 50.px,
                    padding: EdgeInsets.symmetric(
                      vertical: 3.px,
                      horizontal: 8.px,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.appDarkBlack,
                      borderRadius: BorderRadius.circular(30.px),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppImageAsset(
                          image: ImageConstants.proIcon,
                          height: 10.px,
                        ),
                        SizedBox(
                          width: 3.px,
                        ),
                        AppText(
                          'Pro',
                          fontSize: 10.px,
                          fontWeight: FontWeight.w700,
                          color: AppColors.appYellow,
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 4.px,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AppImageAsset(
                      image: countryIcon ?? '',
                      height: 10.px,
                    ),
                    SizedBox(
                      width: 4.px,
                    ),
                    AppText(
                      countryName ?? '',
                      fontSize: 12.px,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 6.px,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   // Check if icon is not null and not empty
                      AppImageAsset(
                        image: ImageConstants.moneyIcon,
                        height: 14.px,
                      ),
                     // Another check for spacing
                      SizedBox(width: 2.px),
                    AppText(
                      subjects ?? '',
                      fontSize: 10.px,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          AppImageAsset(
            image: (isBookmarked ?? false)
                ? ImageConstants.removeBookmark
                : ImageConstants.doBookmark,
            height: 18.px,
          ),
        ],
      ),
    );
  }
}
