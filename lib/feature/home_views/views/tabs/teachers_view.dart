import 'package:flutter/material.dart';

import '../../../../custom/cardView/details_card_view.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';

class TeachersView extends StatelessWidget {
  const TeachersView({super.key});

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
          const SizedBox(height: 20),
          DetailsCardView(
              heading: 'Favorites Teachers',
              reViewLength: 3,
              name: 'User Name',
              avatar: ImageConstants.teacherAvtar,
              countryIcon: ImageConstants.countryIcon,
              countryName: 'Kuwait',
              isPro: true,
              isShowViewAll: true,
              isBookmarked: true,
              subjects: 'Science - Accounta..'),
          DetailsCardView(
              heading: 'Favorites Teachers',
              reViewLength: 3,
              name: 'User Name',
              avatar: ImageConstants.teacherAvtar,
              countryIcon: ImageConstants.countryIcon,
              countryName: 'Kuwait',
              isPro: false,
              isShowViewAll: true,
              isBookmarked: false,
              subjects: 'Science - Accounta..'),
          const SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}
