import 'package:easy_localization/easy_localization.dart';
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
                if (title == 'classFees'.tr())
                  CircleAvatar(
                      backgroundColor: AppColors.appLightRedTwo,
                      radius: 23.px,
                      child: AppImageAsset(
                        image: ImageConstants.readBookIcon,
                        height: 21.px,
                      ))
                else
                  CircleAvatar(
                    backgroundColor: AppColors.greenBG,
                    radius: 23.px,
                    child: AppImageAsset(
                      image: ImageConstants.walletIcon,
                      height: 21.px,
                    ),
                  ),
                SizedBox(width: 15.px),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 260.px,
                      child: Row(
                        children: <Widget>[
                          AppText(
                            title ?? '',
                            fontSize: 14.px,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              AppText(
                                '102',
                                fontSize: 14.px,
                                fontWeight: FontWeight.w700,
                              ),
                              AppText(
                                amount ?? '',
                                fontSize: 10.px,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              AppImageAsset(
                                image: ImageConstants.forwardIcon,
                                height: 14.px,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.px,
                    ),
                    AppText(
                      'Invoice No. $invoiceNumber',
                      fontSize: 10.px,
                      fontWeight: FontWeight.w400,
                      color: AppColors.appGrey,
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
}
