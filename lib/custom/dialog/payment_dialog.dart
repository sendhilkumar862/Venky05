import 'package:flutter/material.dart';
import 'package:hessah/custom/dialog/success_fail_dialog.dart';

import '../../product/constants/colors/app_colors_constants.dart';
import '../divider/divider.dart';
import '../text/app_text.dart';

class PaymentDialog extends StatelessWidget {
   PaymentDialog({this.title,this.content,this.tranId,
    super.key,
  });
  String? title;
  String? content;
  String? tranId;

  @override
  Widget build(BuildContext context) {
    return SuccessFailsInfoDialog(
      title: 'Success',
      buttonTitle: 'Done',
      content: 'You have successfully booked your class!.',
      customWidget: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          AppDivider(),
          SizedBox(
            height: 5,
          ),
          AppText(
            'Transaction Number',
            fontSize: 12,
            color: AppColors.appGrey,
          ),
          SizedBox(
            height: 3,
          ),
          AppText(tranId??''),
        ],
      ),
    );
  }
}
