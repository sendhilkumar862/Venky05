import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';

class AppDivider extends StatelessWidget {
  AppDivider({this.isVerticle, super.key});

  bool? isVerticle;

  @override
  Widget build(BuildContext context) {
    return (isVerticle ?? false)
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 15.px),
            height: double.infinity,
            width: 1.px,
            color: AppColors.appGrey,
          )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              height: 1.px,
              color: Color(0xffC5CEEE),
            ),
          );
  }
}
