import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../../product/extension/context_extension.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class AppCardView extends StatelessWidget {
  AppCardView({
    this.heading,
    this.cardTitle,
    this.date,
    this.timer,
    this.money,
    this.isViewAllIcon = true,
    this.viewAllOnTap,
    this.status,
    this.isPro,
    super.key,
  });

  String? heading;
  String? cardTitle;
  String? date;
  String? timer;
  String? money;
  String? status;
  bool? isViewAllIcon;
  bool? isPro;
  VoidCallback? viewAllOnTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        viewAllCardView(heading!, isViewAllIcon: isViewAllIcon, onTap: viewAllOnTap),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 218,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(top: 5, bottom: 20, left: 15),
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
                        AppImageAsset(
                          image: (status == 'completed')
                              ? ImageConstants.completedStatus
                              : (status == 'accepted')
                                  ? ImageConstants.acceptedStatus
                                  : (status == 'canceled')
                                      ? ImageConstants.canceledStatus
                                      : (status == 'cancelling')
                                          ? ImageConstants.cancellingStatus
                                          : (status == 'created')
                                              ? ImageConstants.createdStatus
                                              : (status == 'incomplete')
                                                  ? ImageConstants
                                                      .incompleteStatus
                                                  : (status == 'pending')
                                                      ? ImageConstants
                                                          .pendingStatus
                                                      : (status ==
                                                              'rescheduling')
                                                          ? ImageConstants
                                                              .reschedulingStatus
                                                          : ImageConstants
                                                              .pendingStatus,
                          height: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        tagCardView(
                          title: 'Grade 2',
                        ),
                        tagCardView(
                          title: 'British',
                        ),
                        tagCardView(
                            title: 'Group', icon: ImageConstants.groupIcon),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        infoCardView(ImageConstants.dateIcon, date!),
                        infoCardView(ImageConstants.timerIcon, timer!),
                        infoCardView(ImageConstants.moneyIcon, money!),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    detailsCardView(isPro: isPro)
                  ],
                ),
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
            image: icon,
            height: 12,
          ),
          const SizedBox(
            width: 4,
          ),
          AppText(
            title,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }

  Container tagCardView({String? title, String? icon}) {
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
          if (icon != null && icon.isNotEmpty) // Another check for spacing
            const SizedBox(width: 4),
          AppText(
            title!,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget viewAllCardView(String title,
      {bool? isViewAllIcon = true, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AppText(
            title,
            fontWeight: FontWeight.w700,
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

  Widget detailsCardView({bool? isPro}) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const AppImageAsset(
                image: ImageConstants.avtar,
                height: 40,
              ),
              SizedBox(
                height: 20,
                width: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return AppImageAsset(
                      image: (index < 3)
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
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Mr. ',
                      style: TextStyle(
                        color: AppColors.appDarkBlack,
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: 'Ahmed Ali',
                      style: TextStyle(
                        color: AppColors.appDarkBlack,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              if(isPro!) SizedBox(
                height: 4,
              ),
              if(isPro!)Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                decoration: BoxDecoration(
                  color: AppColors.appDarkBlack,
                  borderRadius: BorderRadius.circular(30),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImageAsset(
                    image: ImageConstants.countryIcon,
                    height: 10,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  AppText(
                    'Kuwait',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
  Widget statuses(String status)
  {
    switch (status) {
      case "complete":
        return Text("It's an apple!");
      case "orange":
        return Text("It's an orange!");
      case "banana":
        return Text("It's a banana!");
      default:
        return Text("Unknown fruit!");
    }
  }
}
