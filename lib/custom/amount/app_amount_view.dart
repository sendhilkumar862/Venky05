import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../text/app_text.dart';

class AppAmountView extends StatelessWidget {
  const AppAmountView({
    this.amount,
    this.fontWeight,
    this.decimalSize,
    this.firstFontSize,
    super.key,
  });

  final String? amount;
  final FontWeight? fontWeight;
  final double? firstFontSize;
  final double? decimalSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          separator(amount!).first,
          fontSize: firstFontSize ?? 14.px,
          fontWeight: fontWeight ?? FontWeight.w700,
        ),
        AppText(
          amount!=''?'.${separator(amount!).last}':'',
          fontSize: decimalSize ?? 10.px,
          fontWeight: fontWeight ?? FontWeight.w700,
        ),
      ],
    );
  }

  List<String> separator(String amt) {
    return amt.split('.');
  }
}
