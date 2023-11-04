import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

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
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    userDataRow(
                        title: 'Transaction Date', data: '11/10/2023 11:23 AM'),
                    userDataRow(
                        title: 'Transaction Number', data: '#1232132132323'),
                    userDataRow(
                        title: 'Transaction Type', data: 'Top Up Wallet'),
                    userDataRow(title: 'Payment Method', data: 'KNET/CREDIT'),
                    const Divider(),
                    userDataRow(
                        title: 'Top Up Amount',
                        data: '25',
                        data1: '.000 KWD',
                        weight: FontWeight.w700),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () {
                FlutterShare.share(title: 'Check');
              },
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              icon: const Icon(
                Icons.file_download_outlined,
                color: AppColors.white,
              ),
              label: const AppText('Download Invoice', color: AppColors.white))
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          AppText(
            title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.gray,
          ),
          Row(
            children: [
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
