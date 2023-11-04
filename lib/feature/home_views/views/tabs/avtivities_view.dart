import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/cardView/app_card_view.dart';
import '../../../../custom/cardView/heading_card_view.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../custom/cardView/info_card_view_horizontal.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';

class ActivitiesView extends StatelessWidget {
  const ActivitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          InfoCardVIew(
            isShowButton: true,
            title: 'No Activities Found!',
            subTitle:
            "You don't have any pending activities that require your action. If there are scheduled classes or new proposals for the classes you created, etc...\nyou will find them here.",
            cardColor: AppColors.white,
            buttonTitle: 'Create Class',
            buttonTap: () {

            },
          ),
          SizedBox(
            height: 20.px,
          ),
          InfoCardViewHorizontal(
            heading: 'Upcoming Classes',
            isShowButton: true,
            title: 'Create a new class and receive proposals from teachers',
            cardColor: AppColors.lightPurple,
            buttonTap: () {},
          ),
          SizedBox(height: 20.px),
          SizedBox(height: 20.px),
          HeadingCardView(
              title: 'Related Classes', onTap: () {}, totalItem: '3'),
          SizedBox(
            height: 10.px,
          ),
          SizedBox(
            height: 225.px,
            child: ListView.separated(
              padding: EdgeInsets.only(
                  right: 15.px, top: 5.px, bottom: 20.px, left: 15.px),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return AppCardView(
                  cardTitle: 'Math',
                  date: '12/12 12:30pm',
                  timer: '1h 30m',
                  money: '5.500 KWD',
                  status: 'PENDING',
                  isPro: true,
                  avtar: ImageConstants.teacherAvtar,
                  countryIcon: ImageConstants.countryIcon,
                  countryName: 'Kuwait',
                  reViewLength: 3,
                  teacherName: 'Ahmed Ali',
                  buttonTap: () {},
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 15.px,
                );
              },
            ),
          ),
          SizedBox(
            height: 5.px,
          ),
          HeadingCardView(
              title: 'Related Classes', onTap: () {}, totalItem: '3'),
          SizedBox(
            height: 10.px,
          ),
          SizedBox(
            height: 225.px,
            child: ListView.separated(
              padding: EdgeInsets.only(
                  right: 15.px, top: 5.px, bottom: 20.px, left: 15.px),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return AppCardView(
                  cardTitle: 'Math',
                  date: '12/12 12:30pm',
                  timer: '1h 30m',
                  money: '5.500 KWD',
                  status: 'PENDING',
                  isPro: true,
                  avtar: ImageConstants.teacherAvtar,
                  countryIcon: ImageConstants.countryIcon,
                  countryName: 'Kuwait',
                  reViewLength: 3,
                  teacherName: 'Ahmed Ali',
                  buttonTap: () {},
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 15.px,
                );
              },
            ),
          ),
          SizedBox(
            height: 5.px,
          ),
          SizedBox(
            height: 200.px,
          )
        ],
      ),
    );
  }
}
