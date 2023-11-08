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
          Text('Reset Password Link Sent',
              style: openSans.get16.w700.appTextColor),
          Text(
            'Password reset link sent! Please check your email and follow the instructions to reset your password.',
            style: openSans.get14.w400
                .textColor(AppColors.appTextColor.withOpacity(0.5)),
          ),
          Text(
            "Didn't receive the link?",
            style: openSans.get12.w400
                .textColor(AppColors.appTextColor.withOpacity(0.5)),
          ),
          //ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.re), label: "label")
        ],
      ),
    );
  }
}
