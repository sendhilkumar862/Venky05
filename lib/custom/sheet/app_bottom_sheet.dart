import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../product/constants/colors/app_colors_constants.dart';

// ignore: always_specify_types
Future appBottomSheet(
    {required BuildContext context, required Widget commonWidget}) {
  return showModalBottomSheet(
    context: context,
    constraints: const BoxConstraints(),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(25.px),
        topLeft: Radius.circular(25.px),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        width: double.infinity,
        height: (MediaQuery.of(context).size.height * 0.80).px,
        decoration: BoxDecoration(
          color: AppColors.appWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.px),
            topRight: Radius.circular(30.px),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.px),
          children: <Widget>[commonWidget],
        ),
      );
    },
  );
}
