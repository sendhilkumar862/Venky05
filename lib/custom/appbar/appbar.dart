import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../config/routes/app_router.dart';
import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../../product/utils/typography.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class HessaAppBar extends PreferredSize {
  HessaAppBar(
      {super.key,
      this.isTitleOnly = false,
      this.showSuffix = false,
      this.title,
      this.subTitle,
      this.trailingText,
      this.onSearchTap,
      this.onBellTap,
      this.onProfileTap,
      this.leadingTap,
      this.trailingTap,
      this.isPro = false,
      this.isBack = true,
        this.isSearchIconShown=true,
      this.onCallTap,
      this.trailingWidget,
      this.reviewStarLength = 0,
      this.isReviewStar = false,
      this.icon})
      : super(
          child: Container(),
          preferredSize: Size.fromHeight(160.px),
        );
  final String? icon;
  final String? title;
  final String? subTitle;
  final String? trailingText;
  final bool isTitleOnly;
  final bool showSuffix;
  final bool? isPro;
  final bool isBack;
  final bool isSearchIconShown;
  final Widget? trailingWidget;
  final void Function()? leadingTap;
  final void Function()? trailingTap;
  final GestureTapCallback? onProfileTap;
  final GestureTapCallback? onSearchTap;
  final GestureTapCallback? onBellTap;
  final GestureTapCallback? onCallTap;
  final bool? isReviewStar;
  final int? reviewStarLength;

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double appBarHeight = kToolbarHeight + statusBarHeight; // Adjusted for status bar
    return Container(
      alignment: Alignment.centerLeft,
      height: appBarHeight + 30,
      color: AppColors.appWhite,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          const AppImageAsset(
            image: ImageConstants.appBarBG,
            fit: BoxFit.fill,
          ),
          if (isTitleOnly)
            AppBar(
              elevation: 0,
              actions: <Widget>[
                TextButton(
                    onPressed: trailingTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: TextButton(
                        child: Text(
                          trailingText ?? '',
                          style: openSans.get12.w600.textColor(AppColors.appTextColor),
                        ),
                        onPressed: () {
                          AppRouter.pop();
                        },
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(right: 0.px),
                  child: InkWell(onTap: trailingTap, child: trailingWidget ?? SizedBox()),
                )
              ],
              leadingWidth: 0,
              titleSpacing: 2,
              leading: const SizedBox.shrink(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  if (isBack)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: IconButton(
                        onPressed: leadingTap ?? () => AppRouter.pop(),
                        highlightColor: AppColors.trans,
                        hoverColor: AppColors.trans,
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.black,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 15),
                  Text(title ?? '', style: openSans.get16.w700.black),
                  const Spacer(),
                  if (showSuffix)
                    GestureDetector(
                      onTap: onCallTap,
                      child: const AppImageAsset(
                        image: ImageConstants.phoneCall,
                        height: 20,
                      ),
                    ),
                ],
              ),
              backgroundColor: AppColors.trans,
            )
          else
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 5,
              ),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 15),
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
                    child: SizedBox(height: 60,
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
                  ),
                  const SizedBox(width: 23),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppText(
                        title ?? '',
                        fontSize: 14,
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 160,
                        child: AppText(
                          subTitle ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      if (isPro!) const SizedBox(height: 4),
                      if (isPro!)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 3.px, horizontal: 8.px),
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
                  if (isSearchIconShown) GestureDetector(
                    onTap: onSearchTap,
                    child: const AppImageAsset(
                      image: ImageConstants.searchIcon,
                      height: 25,
                    ),
                  ) else const SizedBox.shrink(),
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
