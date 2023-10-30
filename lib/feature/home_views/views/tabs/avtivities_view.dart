import 'package:flutter/material.dart';

import '../../../../custom/cardView/app_card_view.dart';
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
            isViewAllIcon: false,
            viewAllOnTap: () => null,
            buttonTap: () => null,
          ),
          SizedBox(height: 20,),

          InfoCardViewHorizontal(
            heading: 'Upcoming Classes',
            isShowButton: true,
            title: 'Create new class and receive proposals from teachers',
            cardColor: AppColors.lightPurple,
            isViewAllIcon: true,
            viewAllOnTap: () => null,
            buttonTap: () => null,
          ),
          const SizedBox(height: 20),
          AppCardView(
            viewAllOnTap: null,
            totalCards: 3,
            heading: 'Related Classes',
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
          ),
          AppCardView(
            viewAllOnTap: null,
            totalCards: 3,
            heading: 'History',
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
          ),
          const SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}
