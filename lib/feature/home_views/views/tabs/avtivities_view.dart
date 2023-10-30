import 'package:flutter/material.dart';

import '../../../../custom/cardView/app_card_view.dart';

class ActivitiesView extends StatelessWidget {
  const ActivitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          AppCardView(
            heading: 'Related Classes',
            cardTitle: 'Math',
            date: '12/12 12:30pm',
            timer: '1h 30m',
            money: '5.500 KWD',
            status: 'completed',
            isPro: false,
          ),
          AppCardView(
            heading: 'History',
            cardTitle: 'Math',
            date: '12/12 12:30pm',
            timer: '1h 30m',
            money: '5.500 KWD',
            status: 'rescheduling',
            isPro: true,
          ),
        ],
      ),
    );
  }
}
