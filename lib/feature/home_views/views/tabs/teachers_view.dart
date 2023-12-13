import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/cardView/details_card_view.dart';
import '../../../../custom/cardView/heading_card_view.dart';
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
            buttonTitle: 'Class Details',
            buttonTap: () => AppRouter.pushNamed(Routes.classDetailsView),
          ),
          SizedBox(height: 20.px),
          HeadingCardView(
              title: 'Favorites Teachers',
              totalItem: '5',
              onTap: () {},
              isViewAllIcon: true),
          SizedBox(
            height: 5.px,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.300,
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return DetailsCardView(
                    reViewLength: 3,
                    name: 'User Name',
                    avatar: ImageConstants.teacherAvtar,
                    countryIcon: ImageConstants.countryIcon,
                    countryName: 'Kuwait',
                    isPro: true,
                    isBookmarked: true,
                    subjects: 'Science - Accounta..');
              },
            ),
          ),
          HeadingCardView(
              title: 'Favorites Teachers',
              totalItem: '5',
              onTap: () {},
              isViewAllIcon: true),
          SizedBox(
            height: 5.px,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.300,
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return DetailsCardView(
                    reViewLength: 3,
                    name: 'User Name',
                    avatar: ImageConstants.teacherAvtar,
                    countryIcon: ImageConstants.countryIcon,
                    countryName: 'Kuwait',
                    isPro: true,
                    isBookmarked: true,
                    subjects: 'Science - Accounta..');
              },
            ),
          ),
          SizedBox(
            height: 200.px,
          )
        ],
      ),
    );
  }
}
