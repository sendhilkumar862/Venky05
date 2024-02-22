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
    return statuses(status ?? 'Completed'!);
  }

  Widget statuses(String status) {
    switch (status) {
      case 'Completed':
        return customStatusView(
          title: 'Completed',
          icon: ImageConstants.acceptedStatus,
          cardColor: AppColors.appGreen,
          iconColor: AppColors.appWhite,
        );
      case 'Action Needed':
        return customStatusView(
          title: 'Action Needed',
          icon: ImageConstants.warningIcon,
          cardColor: AppColors.appOrange,
          iconColor: AppColors.appWhite,
        );
      case 'Rejected':
        return customStatusView(
          title: 'Rejected',
          icon: ImageConstants.inCompletedStatus,
          cardColor: AppColors.secondaryRed,
          iconColor: AppColors.appWhite,
        );
      case 'Suspended':
        return customStatusView(
          title: 'Suspended',
          icon: ImageConstants.warningIcon,
          cardColor: AppColors.secondaryRed,
          iconColor: AppColors.appWhite,
        );

      case 'Accepted':
        return customStatusView(
          title: 'Accepted',
          icon: ImageConstants.acceptedStatus,
          cardColor: AppColors.appGreen,
          iconColor: AppColors.appWhite,
        );

      case 'Pending':
        return customStatusView(
          title: 'Pending',
          icon: ImageConstants.pendingStatus,
          cardColor: AppColors.appYellow,
          iconColor: AppColors.appDarkBlack,
        );
      case 'Pending Account':
        return customStatusView(
          title: 'Pending Account',
          icon: ImageConstants.pendingStatus,
          cardColor: AppColors.appYellow,
          iconColor: AppColors.appDarkBlack,
        );

      case 'Incomplete':
        return customStatusView(
          title: 'Incomplete',
          icon: ImageConstants.inCompletedStatus,
          cardColor: AppColors.appBorderColor,
          iconColor: AppColors.appDarkBlack,
        );

      case 'Cancelled':
        return customStatusView(
          title: 'Cancelled',
          icon: ImageConstants.inCompletedStatus,
          cardColor: AppColors.appLightRed,
          iconColor: AppColors.appWhite,
        );
      case 'Pending Cancel':
        return customStatusView(
          title: 'Canceling',
          icon: ImageConstants.inCompletedStatus,
          cardColor: AppColors.appLightRed,
          iconColor: AppColors.appWhite,
        );
      case 'Expired':
        return customStatusView(
          title: 'Expired',
          icon: ImageConstants.inCompletedStatus,
          cardColor: AppColors.appLightRed,
          iconColor: AppColors.appWhite,
        );
      case 'Created':
        return customStatusView(
          title: 'Created',
          icon: ImageConstants.pendingStatus,
          cardColor: AppColors.appLightBlue,
          iconColor: AppColors.appWhite,
        );

      case 'Cancelling':
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

      case 'Paying':
        return customStatusView(
          title: 'Paying',
          icon: ImageConstants.payingIcon,
          cardColor: AppColors.appOrange,
          iconColor: AppColors.appWhite,
        );
      case 'New':
        return customStatusView(
          title: 'New',
          icon: ImageConstants.done,
          cardColor: AppColors.appLightBlue,
          iconColor: AppColors.appWhite,
        );
      case 'Inprogress':
        return customStatusView(
          title: 'InProgress',
          icon: ImageConstants.inProgress,
          cardColor: AppColors.appOrange,
          iconColor: AppColors.appWhite,
        );
      case 'Solved':
        return customStatusView(
          title: 'Solved',
          icon: ImageConstants.check,
          cardColor: AppColors.appGreen,
          iconColor: AppColors.appWhite,
        );
      case 'Cancel':
        return customStatusView(
          title: 'Cancelled',
          icon: ImageConstants.cancel,
          cardColor: AppColors.xFFBFC8E4,
          iconColor: AppColors.appTextColor,
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
        mainAxisSize: MainAxisSize.min,
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
