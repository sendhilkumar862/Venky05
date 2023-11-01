import 'package:flutter/material.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../../product/extension/context_extension.dart';
import '../app_button/app_button.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';
import 'heading_card_view.dart';
import 'status_card_view.dart';

class AppCardView extends StatelessWidget {
  AppCardView({
    this.cardTitle,
    this.date,
    this.timer,
    this.money,
    this.buttonTap,
    this.status,
    this.isPro,
    this.countryIcon,
    this.countryName,
    this.reViewLength,
    this.avtar,
    this.teacherName,
    this.proposals,
    super.key,
  });

  String? cardTitle;
  String? date;
  String? timer;
  String? money;
  String? status;
  String? avtar;
  String? teacherName;
  String? countryIcon;
  String? countryName;
  num? reViewLength;
  num? proposals;
  bool? isPro;
  VoidCallback? buttonTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingNormal,
      width: 318,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.appWhite,
        border: Border.all(color: AppColors.lightPurple, width: 1.1),
        boxShadow: AppColors.appCardShadow,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppText(
                cardTitle!,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
              StatusCardView(status: status)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          tagCardView(
            title: 'Grade 2',
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              infoCardView(ImageConstants.dateIcon, date!),
              infoCardView(ImageConstants.timerIcon, timer!),
              infoCardView(ImageConstants.moneyIcon, money!),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          detailsCardView(
              proposals: proposals,
              isPro: isPro,
              name: teacherName,
              avtar: avtar,
              country: countryName,
              countyIcon: countryIcon,
              reViewLength: reViewLength,
              buttonTap: buttonTap)
        ],
      ),
    );
  }

  Padding infoCardView(String icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        children: <Widget>[
          AppImageAsset(
            image: icon ?? '',
            height: 12,
          ),
          const SizedBox(
            width: 4,
          ),
          AppText(
            title ?? '',
            fontSize: 10,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }

  Widget tagCardView({String? title, String? icon}) {
    return SizedBox(
      height: 22,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.lightPurple,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: <Widget>[
                  if (icon != null &&
                      icon.isNotEmpty) // Check if icon is not null and not empty
                    AppImageAsset(
                      image: icon,
                      height: 12,
                    ),
                  if (icon != null &&
                      icon.isNotEmpty) // Another check for spacing
                    const SizedBox(width: 4),
                  AppText(
                    title ?? ''!,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget detailsCardView({
    bool? isPro,
    String? avtar,
    num? reViewLength,
    num? proposals,
    String? name,
    String? countyIcon,
    String? country,
    VoidCallback? buttonTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          if (proposals == 5)
            Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AppImageAsset(
                      image: avtar!,
                      height: 40,
                    ),
                    SizedBox(
                      height: 20,
                      width: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return AppImageAsset(
                            image: (index < reViewLength!)
                                ? ImageConstants.reviewStarPurple
                                : ImageConstants.reviewStar,
                            height: 10,
                            width: 10,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 14,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <InlineSpan>[
                          const TextSpan(
                            text: 'Mr. ',
                            style: TextStyle(
                              color: AppColors.appDarkBlack,
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: name ?? '',
                            style: const TextStyle(
                              color: AppColors.appDarkBlack,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                    if (isPro!)
                      const SizedBox(
                        height: 4,
                      ),
                    if (isPro!)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        decoration: BoxDecoration(
                          color: AppColors.appDarkBlack,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AppImageAsset(
                              image: ImageConstants.proIcon,
                              height: 10,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            AppText(
                              'Pro',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.appYellow,
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppImageAsset(
                          image: countyIcon ?? ''!,
                          height: 10,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        AppText(
                          country ?? ''!,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    )
                  ],
                ),
              ],
            )
          else if (proposals == 0)
            const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    child: AppText('Proposals From',
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      AppImageAsset(
                        image: ImageConstants.teacherAvtar,
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: AppImageAsset(
                          image: ImageConstants.avtar,
                          height: 40,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 32),
                        child: AppImageAsset(
                          image: ImageConstants.avtar,
                          height: 40,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 48),
                        child: AppImageAsset(
                          image: ImageConstants.avtar,
                          height: 40,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 64),
                        child: CircleAvatar(
                          child: AppText('+5',
                              fontWeight: FontWeight.w600,
                              color: AppColors.appWhite),
                        ),
                      )
                    ],
                  )
                ])
          else
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 27,
                ),
                AppText('No proposals received',
                    fontSize: 14, fontWeight: FontWeight.w700),
              ],
            ),
          const Spacer(),
          AppButton(
            title: 'Book',
            width: 60,
            height: 35,
            borderColor: AppColors.appBlue,
            borderRadius: BorderRadius.circular(13),
            onPressed: buttonTap!,
          )
        ],
      ),
    );
  }
}