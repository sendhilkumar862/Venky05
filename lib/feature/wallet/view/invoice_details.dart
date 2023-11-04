// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';

import '../../../custom/appbar/appbar.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';

class InvoiceDetails extends StatefulWidget {
  const InvoiceDetails({super.key});

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        isTitleOnly: true,
        title: 'Invoice Details',
        isBack: true,
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
                    userDataRow(title: 'Transaction Type', data: 'Class Fees'),
                    const Divider(),
                    userDataRow(
                        title: 'Class Cost', data: '5', data1: '.500 KWD'),
                    userDataRow(title: 'Number of Sessions', data: '5'),
                    const Divider(),
                    userDataRow(
                        title: 'Total Class Cost',
                        data: '27',
                        data1: '.500 KWD'),
                    userDataRow(
                        title: 'Hessah Fees', data: '1', data1: '.000 KWD'),
                    const Divider(),
                    userDataRow(
                        title: 'Invoice Amount',
                        data: '28',
                        data1: '.500 KWD',
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
