import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
          SizedBox(
            height: 20.px,
          ),
          SizedBox(height: 20.px),
          HeadingCardView(
              title: 'Related Classes', onTap: () {}, totalItem: '3'),
          SizedBox(
            height: 10.px,
          ),
          SizedBox(
            height: 230.px,
            child: ListView.separated(
              padding: EdgeInsets.only(
                  right: 15.px, top: 5.px, bottom: 20.px, left: 15.px),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
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
                return SizedBox(
                  width: 15.px,
                );
              },
            ),
          ),
          SizedBox(
            height: 5.px,
          ),
          SizedBox(height: 20.px),
          HeadingCardView(
              title: 'Related Classes', onTap: () {}, totalItem: '3'),
          SizedBox(
            height: 10.px,
          ),
          SizedBox(
            height: 230.px,
            child: ListView.separated(
              padding: EdgeInsets.only(
                  right: 15.px, top: 5.px, bottom: 20.px, left: 15.px),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
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
