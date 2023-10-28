
import 'package:flutter/material.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class HessaAppBar extends PreferredSize {
  HessaAppBar({
    super.key,
    this.appBarTitle = '',
    this.onTapBackTap,
    this.isTitle = false,
    this.showSuffix = false,
    this.title,
    this.subTitle,
    this.onSearchTap,
    this.onBellTap,
    this.onProfileTap,
    this.icon
  }) : super(
          child: Container(),
          preferredSize: const Size.fromHeight(160),
        );
  final String appBarTitle;
  final String? icon;
  final String? title;
  final String? subTitle;
  final bool isTitle;
  final bool showSuffix;
  final GestureTapCallback? onTapBackTap;
  final GestureTapCallback? onProfileTap;
  final GestureTapCallback? onSearchTap;
  final GestureTapCallback? onBellTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          alignment: Alignment.centerLeft,
          height: 80,
          color: AppColors.appWhite,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              const AppImageAsset(
                image: ImageConstants.appBarBG,
                fit: BoxFit.fill,
              ),
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.appPurple,
                          spreadRadius: -7,
                          blurRadius: 20,
                          offset: Offset(1, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: GestureDetector(
                        onTap: onProfileTap,
                        child:  AppImageAsset(
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
                        title!,
                        fontSize: 14,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AppText(
                        subTitle!,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
            ],
          ),),
    );
  }
}
