import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
          // isBack: true,
          // normalAppbar: true,
          // titleText: 'Invoice Details',
          ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: <Widget>[
                    userDataRow(
                        title: 'transactionDate'.tr(), data: '11/10/2023 11:23 AM'),
                    userDataRow(
                        title: 'transactionNumber'.tr(), data: '#1232132132323'),
                    userDataRow(
                        title: 'transactionType'.tr(), data: 'Top Up Wallet'),
                    userDataRow(title: 'paymentMethod'.tr(), data: 'KNET/CREDIT'),
                    const Divider(),
                    userDataRow(
                        title: 'topUpAmount'.tr(),
                        data: '25',
                        data1: '.000 KWD',
                        weight: FontWeight.w700),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () {},
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              icon: const Icon(
                Icons.file_download_outlined,
                color: AppColors.white,
              ),
              label:  AppText('downloadInvoice'.tr(), color: AppColors.white))
        ],
      ),
    );
  }

  Widget userDataRow(
      {required String title,
      required String data,
      String data1 = '',
      FontWeight? weight}) {
    if (data.isNotEmpty || data != '') {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          AppText(
            title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.gray,
          ),
          Row(
            children: <Widget>[
              AppText(
                data,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                fontSize: 16,
                fontWeight: weight ?? FontWeight.w500,
                color: AppColors.black,
              ),
              AppText(
                data1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                fontSize: 12,
                fontWeight: weight ?? FontWeight.w500,
                color: AppColors.black,
              ),
            ],
          ),
        ]),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
