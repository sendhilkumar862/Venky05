import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';

class InvoiceCardView extends StatelessWidget {
  InvoiceCardView(
      {super.key,
      this.title,
      this.invoiceNumber,
      this.amount,
      this.date,
      this.onTap});

  VoidCallback? onTap;
  final String? date;
  final String? title;
  final String? invoiceNumber;
  final String? amount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 15.px),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 4.px,
            ),
            if (date!.isNotEmpty)
              AppText(
                date ?? '',
                textAlign: TextAlign.start,
                color: AppColors.gray,
                fontSize: 12.px,
                fontWeight: FontWeight.w700,
              ),
            if (date!.isNotEmpty)
              SizedBox(
                height: 8.px,
              ),
            Row(
              children: <Widget>[
                walletIcon(title!),
                SizedBox(width: 15.px),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText(
                      title == 'class_credit'
                          ? 'Class Fee Credit'
                          : title == 'cancel_class'
                              ? 'Refund'
                              : title == 'reload_balance'
                                  ? 'Wallet TopUp'
                                  : title == 'buy_class'
                                      ? 'Class Fees'
                                      : title == 'subscription'
                                          ? 'Subscription'
                                          : 'Withdraw',
                      fontSize: 14.px,
                    ),
                    SizedBox(
                      height: 4.px,
                    ),
                    SizedBox(
                      width: 200.px,
                      child: AppText(
                        'Invoice No. $invoiceNumber',
                        fontSize: 10.px,
                        fontWeight: FontWeight.w400,
                        color: AppColors.appGrey,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    AppText(
                      amount?.split('.')[0] ?? '',
                      fontSize: 14.px,
                      fontWeight: FontWeight.w700,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: AppText(
                        '.${amount?.split('.')[1] ?? ''} KWD',
                        fontSize: 10.px,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    AppImageAsset(
                      image: ImageConstants.forwardIcon,
                      height: 30.px,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 4.px,
            ),
          ],
        ),
      ),
    );
  }

  Widget walletIcon(String titleValue) {
    if (titleValue == 'class_credit') {
      return CircleAvatar(
          backgroundColor: AppColors.appLightRedTwo,
          radius: 23.px,
          child: AppImageAsset(
            image: ImageConstants.readBookIcon,
            height: 21.px,
          ));
    } else if (titleValue == 'reload_balance') {
      return CircleAvatar(
          backgroundColor: AppColors.appLightRedTwo,
          radius: 23.px,
          child: AppImageAsset(
            image: ImageConstants.walletIcon,
            height: 21.px,
          ));
    } else if (titleValue == 'subscription') {
      return CircleAvatar(
          backgroundColor: AppColors.appLightRedTwo,
          radius: 23.px,
          child: AppImageAsset(
            image: ImageConstants.subscriptionIcon,
            height: 21.px,
          ));
    } else if (titleValue == 'buy_class') {
      return CircleAvatar(
          backgroundColor: AppColors.appLightRedTwo,
          radius: 23.px,
          child: AppImageAsset(
            image: ImageConstants.readBookIcon,
            height: 21.px,
          ));
    } else if (titleValue == 'cancel_class') {
      return CircleAvatar(
          backgroundColor: AppColors.appLightRedTwo,
          radius: 23.px,
          child: AppImageAsset(
            image: ImageConstants.readBookIcon,
            height: 21.px,
          ));
    } else {
      return CircleAvatar(
        backgroundColor: AppColors.greenBG,
        radius: 23.px,
        child: AppImageAsset(
          image: ImageConstants.withdrawIcon,
          height: 21.px,
        ),
      );
    }
  }
}
