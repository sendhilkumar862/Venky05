import 'package:flutter/material.dart';
import '../../../../custom/cardView/app_card_view.dart';
import '../../../../custom/cardView/heading_card_view.dart';
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
          HeadingCardView(
              title: 'Related Classes', onTap: () {}, totalItem: '3'),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 225,
            child: ListView.separated(
              padding: const EdgeInsets.only(
                  right: 15, top: 5, bottom: 20, left: 15),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 3 ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return AppCardView(
                  proposals: 0,
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
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 15,
                );
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(height: 20),
          HeadingCardView(
              title: 'Related Classes', onTap: () {}, totalItem: '3'),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 225,
            child: ListView.separated(
              padding: const EdgeInsets.only(
                  right: 15, top: 5, bottom: 20, left: 15),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 3 ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return AppCardView(
                  proposals: 0,
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
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 15,
                );
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}
