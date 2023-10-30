import 'package:flutter/material.dart';
import '../../../../custom/cardView/app_card_view.dart';
import '../../../../product/constants/image/image_constants.dart';

class ClassesView extends StatelessWidget {
  const ClassesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const SizedBox(height: 20),
          AppCardView(
            proposals: 0,
            viewAllOnTap: null,
            totalCards: 3,
            heading: 'Related Classes',
            cardTitle: 'Math',
            date: '12/12 12:30pm',
            timer: '1h 30m',
            money: '5.500 KWD',
            status: 'COMPLETED',
            isPro: true,
            avtar: ImageConstants.teacherAvtar,
            countryIcon: ImageConstants.countryIcon,
            countryName: 'Kuwait',
            reViewLength: 3,
            teacherName: 'Ahmed Ali',
            buttonTap: () {},
          ),
          AppCardView(
            proposals: 5,
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
          AppCardView(
            proposals: 3,
            viewAllOnTap: null,
            totalCards: 3,
            heading: 'History',
            cardTitle: 'Math',
            date: '12/12 12:30pm',
            timer: '1h 30m',
            money: '5.500 KWD',
            status: 'CANCELLED',
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
