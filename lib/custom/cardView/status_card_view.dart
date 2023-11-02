import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/constants/image/image_constants.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class StatusCardView extends StatelessWidget {
  StatusCardView({
    this.status,
    super.key,
  });

  String? status;

  @override
  Widget build(BuildContext context) {
    return statuses(status ?? 'COMPLETED'!);
  }

  Widget statuses(String status) {
    switch (status) {
      case 'COMPLETED':
        return customStatusView(
          title: 'Completed',
          icon: ImageConstants.acceptedStatus,
          cardColor: AppColors.appGreen,
          iconColor: AppColors.appWhite,
        );

      case 'ACCEPTED':
        return customStatusView(
          title: 'Accepted',
          icon: ImageConstants.acceptedStatus,
          cardColor: AppColors.appGreen,
          iconColor: AppColors.appWhite,
        );

      case 'PENDING':
        return customStatusView(
          title: 'Pending',
          icon: ImageConstants.pendingStatus,
          cardColor: AppColors.appYellow,
          iconColor: AppColors.appDarkBlack,
        );

      case 'INCOMPLETE':
        return customStatusView(
          title: 'Incomplete',
          icon: ImageConstants.inCompletedStatus,
          cardColor: AppColors.appBorderColor,
          iconColor: AppColors.appDarkBlack,
        );

      case 'CANCELLED':
        return customStatusView(
          title: 'Cancelled',
          icon: ImageConstants.inCompletedStatus,
          cardColor: AppColors.appLightRed,
          iconColor: AppColors.appWhite,
        );

      case 'CREATED':
        return customStatusView(
          title: 'Created',
          icon: ImageConstants.pendingStatus,
          cardColor: AppColors.appLightBlue,
          iconColor: AppColors.appWhite,
        );

      case 'CANCELLING':
        return customStatusView(
          title: 'Cancelling',
          icon: ImageConstants.cancellingStatus,
          cardColor: AppColors.appOrange,
          iconColor: AppColors.appWhite,
        );

      case 'RESCHEDULING':
        return customStatusView(
          title: 'Rescheduling',
          icon: ImageConstants.reschedulingStatus,
          cardColor: AppColors.appOrange,
          iconColor: AppColors.appWhite,
        );

      case 'PAYING':
        return customStatusView(
          title: 'Paying',
          icon: ImageConstants.payingIcon,
          cardColor: AppColors.appOrange,
          iconColor: AppColors.appWhite,
        );

      default:
        return customStatusView(
          title: 'Completed',
          icon: ImageConstants.acceptedStatus,
          cardColor: AppColors.appGreen,
          iconColor: AppColors.appWhite,
        );
    }
  }

  Container customStatusView({
    Color? cardColor,
    String? icon,
    String? title,
    Color? iconColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 3.px),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.px),
        color: cardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppImageAsset(
            image: icon!,
            height: 16.px,
            color: iconColor,
          ),
          SizedBox(
            width: 3.px,
          ),
          AppText(
            title!,
            color: iconColor,
            fontSize: 10.px,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
