import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../text/app_text.dart';

class AppAmountView extends StatelessWidget {
  const AppAmountView({
    this.amount,
    this.fontWeight,
    this.decimalSize,
    this.firstFontSize,
    this.isClasses=false,
    super.key,
  });

  final String? amount;
  final FontWeight? fontWeight;
  final double? firstFontSize;
  final double? decimalSize;
  final bool isClasses;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: avoid_redundant_argument_values
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        AppText(
          separator(amount!).first,
          fontSize: firstFontSize ?? 14.px,
          fontWeight: fontWeight ?? FontWeight.w700,
        ),
        if (!isClasses) Padding(
          padding: const EdgeInsets.only(bottom:2.0),
          child: AppText(
            amount!=''?'.${separator(amount!).last}':'',
            fontSize: decimalSize ?? 10.px,
            fontWeight: fontWeight ?? FontWeight.w700,
          ),
        ) else const SizedBox.shrink(),
      ],
    );
  }

  List<String> separator(String amt) {
    return amt.split('.');
  }
}
