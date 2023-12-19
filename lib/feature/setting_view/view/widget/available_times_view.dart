
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../profile/view/profile_view.dart';
import 'calender_view/manage_added_time_view.dart';

class AvailableTimesView extends StatefulWidget {
  const AvailableTimesView({super.key});

  @override
  State<AvailableTimesView> createState() => _AvailableTimesViewState();
}

class _AvailableTimesViewState extends State<AvailableTimesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        title: 'availableTimes'.tr,
        isTitleOnly: true,
      ),
      body: Column(
        children: [
          const AvailableTimesCalender(),
          AppButton(
              title: 'Add Time',
              onPressed: () {
                AppRouter.push(ManageAddedTimeView());
              })
        ],
      ),
    );
  }
}
