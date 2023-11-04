import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../text/app_text.dart';

class AppAmountView extends StatelessWidget {
  AppAmountView({
    this.amount,
    this.fontWeight,
    this.decimalSize,
    this.firstFontSize,
    super.key,
  });

  String? amount;
  FontWeight? fontWeight;
  double? firstFontSize;
  double? decimalSize;

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
          '.${separator(amount!).last}',
          fontSize: decimalSize ?? 10.px,
          fontWeight: fontWeight ?? FontWeight.w700,
        ),
      ],
    );
  }

  List<String> separator(String amt) {
    // ignore: always_specify_types
    List amount = <String>[];
    return amount = amt.split('.');
  }
}
