import 'package:flutter/material.dart';

import '../../product/constants/colors/app_colors_constants.dart';

class AppSwitch extends StatelessWidget {
  AppSwitch({
    super.key,this.onTap,
    required this.isActive,
  });

  bool? isActive;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.all(4),
        alignment: isActive! ? Alignment.centerRight : Alignment.centerLeft,
        height: 19,
        width: 35,
        decoration: BoxDecoration(
          color: isActive! ? AppColors.appBlue : AppColors.appGrey,
          borderRadius: BorderRadius.circular(27),
        ),
        child: Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
              color: isActive! ? AppColors.appWhite : AppColors.appWhite,
              shape: BoxShape.circle),
        ),
      ),
    );
  }
}
