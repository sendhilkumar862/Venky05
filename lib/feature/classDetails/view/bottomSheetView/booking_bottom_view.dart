import 'package:flutter/material.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/dialog/payment_dialog.dart';
import '../../../../custom/divider/divider.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';


class BookingBottomSheet extends StatelessWidget {
  const BookingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 14),
              alignment: Alignment.center,
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                  color: AppColors.appLightGrey, shape: BoxShape.circle),
              child: const AppImageAsset(
                image: ImageConstants.closeIcon,
                height: 20,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              const SizedBox(
                height: 28,
              ),
              const AppText(
                'Booking Confirmation',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                height: 23,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  'Payment Method',
                  fontSize: 16,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Row(
                children: <Widget>[
                  AppImageAsset(
                    image: ImageConstants.kNetLogo,
                    height: 20,
                  ),
                  SizedBox(width: 8),
                  AppImageAsset(
                    image: ImageConstants.visaLogo,
                    height: 12,
                  ),
                  SizedBox(width: 8),
                  AppImageAsset(
                    image: ImageConstants.mastercardLogo,
                    height: 20,
                  ),
                  SizedBox(width: 8),
                  AppImageAsset(
                    image: ImageConstants.applePayLogo,
                    height: 20,
                  ),
                  SizedBox(width: 8),
                  AppImageAsset(
                    image: ImageConstants.gPayLogo,
                    height: 20,
                  ),
                  SizedBox(width: 8),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: <Widget>[
                  const AppText(
                    'Use Wallet',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.appGrey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      AppText('27', fontSize: 16, fontWeight: FontWeight.w700),
                      AppText('.500 KWD',
                          fontSize: 12, fontWeight: FontWeight.w700),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: customSwitch(true),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const AppDivider(),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  'Payment Summary',
                  fontSize: 16,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppText(
                    'Class Cost',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.appGrey,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      AppText('27',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.appGrey),
                      AppText('.500 KWD',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.appGrey),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppText(
                    'Number of Sessions',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.appGrey,
                  ),
                  AppText('5',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.appGrey)
                ],
              ),
              const AppDivider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppText(
                    'Total Classes Cost',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.appGrey,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      AppText('27',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.appGrey),
                      AppText('.500 KWD',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.appGrey),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppText(
                    'Hessah Fees',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.appGrey,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      AppText('27',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.appGrey),
                      AppText('.500 KWD',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.appGrey),
                    ],
                  ),
                ],
              ),
              const AppDivider(),
              const SizedBox(
                height: 5,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppText(
                    'Amount to pay',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.appGrey,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      AppText(
                        '27',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        '.500 KWD',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              AppButton(
                borderColor: AppColors.appBlue,
                height: 45,
                title: 'pay',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 30,
                      // here increase or decrease in width
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    builder: (BuildContext context) {
                      return PaymentDialog(
                        tranId: '#232132132132133',
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ignore: always_specify_types
  Container customSwitch(isActive) {
    return Container(
      padding: const EdgeInsets.all(4),
      alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
      height: 19,
      width: 35,
      decoration: BoxDecoration(
        color: isActive ? AppColors.appBlue : AppColors.appGrey,
        borderRadius: BorderRadius.circular(27),
      ),
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
            color: isActive ? AppColors.appWhite : AppColors.appWhite,
            shape: BoxShape.circle),
      ),
    );
  }
}
