import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../config/routes/app_router.dart';
import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class HessaAppBar extends PreferredSize {
  HessaAppBar({super.key,
    this.isTitleOnly = false,
    this.showSuffix = false,
    this.title,
    this.subTitle,
    this.onSearchTap,
    this.onBellTap,
    this.onProfileTap,
    this.isPro = false,
    this.icon})
      : super(
    child: Container(),
    preferredSize: const Size.fromHeight(160),
  );
  final String? icon;
  final String? title;
  final String? subTitle;
  final bool isTitleOnly;
  final bool showSuffix;
  final bool? isPro;
  final GestureTapCallback? onProfileTap;
  final GestureTapCallback? onSearchTap;
  final GestureTapCallback? onBellTap;

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    return Container(
      alignment: Alignment.centerLeft,
      height: 110,
      color: AppColors.appWhite,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          const AppImageAsset(
            image: ImageConstants.appBarBG,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: isTitleOnly
                ? Row(
              children: <Widget>[
                IconButton(
                  onPressed: () => AppRouter.pop(),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.appDarkBlack,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                AppText(
                  title!,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),

              ],
            )
                : Row(
              children: <Widget>[
                const SizedBox(
                  width: 15,
                ),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColors.appPurple.withOpacity(0.4),
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: const Offset(1, 7),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: GestureDetector(
                      onTap: onProfileTap,
                      child: AppImageAsset(
                        image: icon!,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 23),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText(
                      title ?? ''!,
                      fontSize: 14,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      width: 160,
                      child: AppText(
                        subTitle ?? ''!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    if(isPro!) const SizedBox(
                      height: 4,
                    ),
                    if(isPro!) Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 3.px, horizontal: 8.px),
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

                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onSearchTap,
                  child: const AppImageAsset(
                    image: ImageConstants.searchIcon,
                    height: 25,
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                GestureDetector(
                  onTap: onBellTap,
                  child: const AppImageAsset(
                    image: ImageConstants.bellIcon,
                    height: 20,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
