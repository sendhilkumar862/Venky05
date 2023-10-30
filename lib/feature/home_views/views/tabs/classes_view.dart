import 'package:flutter/material.dart';

import '../../../../custom/cardView/app_card_view.dart';

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
          AppCardView(
            viewAllOnTap: null,
            heading: 'Related Classes',
            cardTitle: 'Math',
            date: '12/12 12:30pm',
            timer: '1h 30m',
            money: '5.500 KWD',
            status: 'completed',
            isPro: true,
          ),
          AppCardView(
            viewAllOnTap: null,
            heading: 'History',
            cardTitle: 'Math',
            date: '12/12 12:30pm',
            timer: '1h 30m',
            money: '5.500 KWD',
            status: 'rescheduling',
            isPro: false,
          ),
          const SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}
