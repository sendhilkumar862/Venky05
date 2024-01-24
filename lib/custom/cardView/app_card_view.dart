import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../../product/extension/context_extension.dart';
import '../app_button/app_button.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';
import 'status_card_view.dart';

class AppCardView extends StatelessWidget {
  AppCardView({
    this.cardTitle,
    this.date,
    this.timer,
    this.money,
    this.buttonTap,
    this.status,
    this.isPro = false,
    this.countryIcon,
    this.countryName,
    this.reViewLength,
    this.avtar,
    this.teacherName,
    this.grade,
    this.minParticipants,
    this.maxParticipants,
    this.proposals,
    this.isBook=true,
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
  String? grade;
  String? countryName;
  num? reViewLength;
  num? proposals;
  bool? isPro;
  int? minParticipants;
  int? maxParticipants;
  VoidCallback? buttonTap;
  bool isBook;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(onTap:   buttonTap,
          child: Container(
            padding: context.paddingNormal,
            width: 500.px,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.appWhite,
              border: Border.all(color: AppColors.lightPurple, width: 1.1),
              boxShadow: AppColors.appCardShadow,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppText(
                      cardTitle!,
                      fontWeight: FontWeight.w800,
                      fontSize: 20.px,
                    ),
                    StatusCardView(status: status)
                  ],
                ),
                SizedBox(
                  height: 10.px,
                ),
                Row(
                  children: [
                    tagCardView(
                      title: grade,
                    ),
                    tagCardView(
                      title: countryName,
                    ),
                    tagCardView(
                        title: maxParticipants==1?'Individual':'$minParticipants/$maxParticipants',
                        icon:  maxParticipants==1?ImageConstants.individualIcon:ImageConstants.groupIcon,
                        isBold: true),
                  ],
                ),
                SizedBox(
                  height: 10.px,
                ),
                Row(
                  children: <Widget>[
                    infoCardView(ImageConstants.dateIcon, date!),
                    infoCardView(ImageConstants.timerIcon, timer!),
                    infoCardView(ImageConstants.moneyIcon, money!),
                  ],
                ),
                SizedBox(
                  height: 10.px,
                ),
                detailsCardView(
                  proposals: proposals,
                  isPro: isPro,
                  isBook: isBook,
                  name: teacherName,
                  avtar: avtar,
                  country: countryName,
                  countyIcon: countryIcon,
                  reViewLength: reViewLength,
                  buttonTap: buttonTap,

                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Padding infoCardView(String icon, String title) {
    return Padding(
      padding: EdgeInsets.only(right: 12.px),
      child: Row(
        children: <Widget>[
          AppImageAsset(
            image: icon ?? '',
            height: 12.px,
          ),
          SizedBox(
            width: 4.px,
          ),
          AppText(
            title ?? '',
            fontSize: 10.px,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
  Widget tagCardView({String? title, String? icon, bool isBold = false}) {
    return Container(
      margin: EdgeInsets.only(right: 5.px),
      padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 5.px),
      decoration: BoxDecoration(
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(30.px),
      ),
      child: Row(
        children: <Widget>[
          if (icon != null &&
              icon.isNotEmpty) // Check if icon is not null and not empty
            AppImageAsset(
              image: icon,
              height: 12.px,
            ),
          if (icon != null && icon.isNotEmpty) // Another check for spacing
            SizedBox(width: 4.px),
          AppText(
            title ?? '',
            fontSize: 10.px,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ],
      ),
    );
    return SizedBox(
      height: 22.px,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {},
        ),
      ),
    );
  }

  Widget detailsCardView({
    bool? isPro,
    required bool isBook,
    String? avtar,
    num? reViewLength,
    num? proposals,
    String? name,
    String? countyIcon,
    String? country,
    VoidCallback? buttonTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.px),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(10.px),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.px),
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
                        height: 40.px,
                      ),
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
                    ],
                  ),
                  SizedBox(
                    width: 14.px,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                                color: AppColors.appDarkBlack,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.px,
                              ),
                            )
                          ],
                        ),
                      ),
                      if (isPro!)
                        SizedBox(
                          height: 4.px,
                        ),
                      if (isPro)
                        Container(
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
                      SizedBox(
                        height: 4.px,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AppImageAsset(
                            image: countyIcon ?? '',
                            height: 10.px,
                          ),
                          SizedBox(
                            width: 4.px,
                          ),
                          AppText(
                            country ?? '',
                            fontSize: 12.px,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              )
            else if (proposals == 0)
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 50.px,
                      child: AppText('Proposals From',
                          fontSize: 12.px, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 10.px,
                    ),
                    Stack(
                      children: List.generate(
                          5,
                          (index) => Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        index.toDouble()* 16.px),
                                child: index != 4
                                    ? AppImageAsset(
                                        image: ImageConstants.teacherAvtar,
                                        height: 40.px,
                                      )
                                    : const CircleAvatar(
                                        child: AppText('+5',
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.appWhite),
                                      ),
                              )),
                    ),
                  ])
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 27.px,
                  ),
                  AppText('No proposals received',
                      fontSize: 14.px, fontWeight: FontWeight.w700),
                ],
              ),
            const Spacer(),
           if(isBook) SizedBox(
              child: AppButton(
                title: 'Book',
                isDisable: false,
                width: 60.px,
                height: 35.px,
                borderColor: AppColors.appBlue,
                borderRadius: BorderRadius.circular(13.px),
                onPressed: buttonTap!,
              ),
            )
          ],
        ),
      ),
    );
  }
}
