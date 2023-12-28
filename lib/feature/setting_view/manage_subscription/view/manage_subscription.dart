import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/cardView/status_card_view.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/sheet/app_bottom_sheet.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/typography.dart';
import '../../../classDetails/view/bottomSheetView/booking_bottom_view.dart';


class ManageSubscription extends StatefulWidget {
  const ManageSubscription({super.key});

  @override
  State<ManageSubscription> createState() => _ManageSubscriptionState();
}

class _ManageSubscriptionState extends State<ManageSubscription> {
  List<SubscribeNowHeading> subscribeNowList = [
    SubscribeNowHeading(heading: 'Pro', currency: '10 KWD', subscribeNowList: [
      SubscribeNow(
          title:
              'More trustable teacher profile and recommended by Hessah app.'),
      SubscribeNow(title: 'Min rating required 4/5.'),
      SubscribeNow(title: 'Min teaching experience is 5 years.'),
      SubscribeNow(title: 'Min classes completed in Hessah is 10'),
    ]),
    SubscribeNowHeading(heading: 'Ads', currency: '20 KWD', subscribeNowList: [
      SubscribeNow(title: 'Teacher profile showed more frequent'),
      SubscribeNow(title: 'Priority to show profile at first search results'),
    ])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        title: 'Manage Subscription ',
        isTitleOnly: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ListView.builder(
                      itemCount: subscribeNowList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = subscribeNowList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                transform: const GradientRotation(6),
                                colors: [
                                  AppColors.appBlue,
                                  Colors.white,
                                  Colors.white,
                                  Colors.white.withOpacity(0.1)
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.appBorderColor
                                      .withOpacity(0.5)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 12, top: 8),
                                      child: Text(
                                        data.heading,
                                        style: openSans.get36.w800
                                            .textColor(
                                            AppColors.primaryColor),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 5),
                                      child: StatusCardView(
                                        status: data.heading == 'Pro'
                                            ? 'PRO'
                                            : 'ADS',
                                      ),
                                    )
                                  ],
                                ),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.subscribeNowList.length,
                                  itemBuilder:
                                      (BuildContext context, int i) {
                                    var res = data.subscribeNowList[i];
                                    return Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        AppImageAsset(
                                          image: ImageConstants
                                              .starSecondary,
                                          height: 18.px,
                                          color: AppColors.primaryColor,
                                        ),
                                        Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, bottom: 5),
                                              child: Text(res.title,
                                                  style: openSans.get14.w400
                                                      .appTextColor),
                                            ))
                                      ],
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: '10 KWD',
                                            style: openSans
                                                .get20.w700.appTextColor),
                                        TextSpan(
                                            text: ' Per Month',
                                            style: openSans
                                                .get12.w400.appTextColor),
                                      ],
                                    ),
                                  ),
                                ),
                                AppButton(
                                    isDisable: false,
                                    title: 'Subscribe Now',
                                    onPressed: () {
                                      data.heading == 'Ads'
                                          ? appBottomSheet(
                                          context: context,
                                          commonWidget:
                                          BookingBottomSheet())
                                          : Text(
                                        'You are not eligible at this time for this plan',
                                      );
                                    })
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscribeNow {
  SubscribeNow({
    required this.title,
  });

  final String title;
}

class SubscribeNowHeading {
  SubscribeNowHeading(
      {required this.currency,
      required this.heading,
      required this.subscribeNowList});
  final String heading;
  final String currency;
  List<SubscribeNow> subscribeNowList;
}
