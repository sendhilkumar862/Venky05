import 'package:flutter/material.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../../product/extension/context_extension.dart';
import '../app_button/app_button.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class AppCardView extends StatelessWidget {
  AppCardView({
    this.totalCards,
    this.heading,
    this.cardTitle,
    this.date,
    this.timer,
    this.money,
    this.isViewAllIcon = true,
    this.viewAllOnTap,
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

  int? totalCards;
  String? heading;
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
  bool? isViewAllIcon;
  bool? isPro;
  VoidCallback? viewAllOnTap;
  VoidCallback? buttonTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        viewAllCardView(heading!,
            isViewAllIcon: isViewAllIcon,
            onTap: viewAllOnTap,
            totalItem: totalCards),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 225,
          child: ListView.separated(
            padding: const EdgeInsets.only(right: 15, top: 5, bottom: 20, left: 15),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: totalCards ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
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
                        statuses(status!)
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
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 15,
              );
            },
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
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
          itemBuilder: (context, index) {
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

  Widget viewAllCardView(String title,
      {bool? isViewAllIcon = true, VoidCallback? onTap, num? totalItem}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              AppText(
                title,
                fontWeight: FontWeight.w700,
              ),
              AppText(
                ' ($totalItem)',
                fontWeight: FontWeight.w700,
                color: AppColors.appGrey,
              ),
            ],
          ),
          if (isViewAllIcon!)
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: onTap,
                  child: const AppText(
                    'View All',
                    color: AppColors.appBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const AppImageAsset(
                  image: ImageConstants.layersIcon,
                  height: 18,
                ),
              ],
            )
        ],
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
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                children: [
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

  Widget statuses(String status) {
    switch (status) {
      case 'COMPLETED':
        return customStatusView(
            title: 'Completed',
            icon: ImageConstants.acceptedStatus,
            cardColor: AppColors.appGreen,
            iconColor: AppColors.appWhite);

      case 'ACCEPTED':
        return customStatusView(
            title: 'Accepted',
            icon: ImageConstants.acceptedStatus,
            cardColor: AppColors.appGreen,
            iconColor: AppColors.appWhite);

      case 'PENDING':
        return customStatusView(
            title: 'Pending',
            icon: ImageConstants.pendingStatus,
            cardColor: AppColors.appYellow,
            iconColor: AppColors.appDarkBlack);

      case 'INCOMPLETE':
        return customStatusView(
            title: 'Incomplete',
            icon: ImageConstants.inCompletedStatus,
            cardColor: AppColors.appBorderColor,
            iconColor: AppColors.appDarkBlack);

      case 'CANCELLED':
        return customStatusView(
            title: 'Cancelled',
            icon: ImageConstants.inCompletedStatus,
            cardColor: AppColors.appLightRed,
            iconColor: AppColors.appWhite);

      case 'CREATED':
        return customStatusView(
            title: 'Created',
            icon: ImageConstants.pendingStatus,
            cardColor: AppColors.appLightBlue,
            iconColor: AppColors.appWhite);

      case 'CANCELLING':
        return customStatusView(
            title: 'Cancelling',
            icon: ImageConstants.cancellingStatus,
            cardColor: AppColors.appOrange,
            iconColor: AppColors.appWhite);

      case 'RESCHEDULING':
        return customStatusView(
            title: 'Rescheduling',
            icon: ImageConstants.reschedulingStatus,
            cardColor: AppColors.appOrange,
            iconColor: AppColors.appWhite);

      default:
        return customStatusView(
            title: 'Completed',
            icon: ImageConstants.acceptedStatus,
            cardColor: AppColors.appGreen,
            iconColor: AppColors.appWhite);
    }
  }

  Container customStatusView(
      {Color? cardColor, String? icon, String? title, Color? iconColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: cardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppImageAsset(
            image: icon!,
            height: 16,
            color: iconColor,
          ),
          const SizedBox(
            width: 3,
          ),
          AppText(title!,
              color: iconColor!, fontSize: 10, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}
