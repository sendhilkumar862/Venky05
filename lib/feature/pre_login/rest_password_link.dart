import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../custom/appbar/appbar.dart';
import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/utils/typography.dart';

class RestPassword extends StatefulWidget {
  const RestPassword({super.key});

  @override
  State<RestPassword> createState() => _RestPasswordState();
}

class _RestPasswordState extends State<RestPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        isTitleOnly: true,
      ),
      body: Column(
        children: [
          Text('resetPasswordLinkSent'.tr(),
              style: openSans.get16.w700.appTextColor),
          Text(
            'passwordResetLink'.tr(),
            style: openSans.get14.w400
                .textColor(AppColors.appTextColor.withOpacity(0.5)),
          ),
          Text(
            "didn'tReceiveTheLink".tr(),
            style: openSans.get12.w400
                .textColor(AppColors.appTextColor.withOpacity(0.5)),
          ),
          //ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.re), label: "label")
        ],
      ),
    );
  }
}
