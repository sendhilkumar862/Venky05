// ignore_for_file: always_specify_types

import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

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
        title: 'invoiceDetails'.tr(),
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
                        title: 'transactionDate'.tr(), data: '11/10/2023 11:23 AM'),
                    userDataRow(
                        title: 'transactionNumber'.tr(), data: '#1232132132323'),
                    userDataRow(title: 'Transaction Type', data: 'Class Fees'),
                    const Divider(),
                    userDataRow(
                        title: 'classCost'.tr(), data: '5', data1: '.500 KWD'),
                    userDataRow(title: 'numberOfSessions'.tr(), data: '5'),
                    const Divider(),
                    userDataRow(
                        title: 'totalClassCost'.tr(),
                        data: '27',
                        data1: '.500 KWD'),
                    userDataRow(
                        title: 'hessahFees'.tr(), data: '1', data1: '.000 KWD'),
                    const Divider(),
                    userDataRow(
                        title: 'invoiceAmount'.tr(),
                        data: '28',
                        data1: '.500 KWD',
                        weight: FontWeight.w700),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                final file = await generatePDF(
                  transactionDate: '11/10/2023 11:23 AM',
                  transactionNumber: '#1232132132323',
                  transactionType: 'classFees'.tr(),
                  classCost: '5.000 KWD',
                  numberOfSessions: '5',
                  totalClassCost: '27.500 KWD',
                  hessahFees: '1.000 KWD',
                  invoiceAmount: '28.500 KWD',
                );
                Share.shareFiles([file.path], text: 'sharingInvoicePDF'.tr());
              },
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

  Future<File> generatePDF({
    required String transactionDate,
    required String transactionNumber,
    required String transactionType,
    required String classCost,
    required String numberOfSessions,
    required String totalClassCost,
    required String hessahFees,
    required String invoiceAmount,
  }) async {
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(10),
                border: pw.Border.all(color: PdfColor.fromInt(0xFF000000)),
              ),
              child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                    vertical: 25,
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      _buildDataRow('transactionDate:'.tr(), transactionDate),
                      _buildDataRow('transactionNumber:'.tr(), transactionNumber),
                      _buildDataRow('transactionType:'.tr(), transactionType),
                      _buildDivider(),
                      _buildDataRow('classCost:'.tr(), classCost),
                      _buildDataRow('numberOfSessions:'.tr(), numberOfSessions),
                      _buildDivider(),
                      _buildDataRow('totalClassCost:'.tr(), totalClassCost),
                      _buildDataRow('hessahFees:'.tr(), hessahFees),
                      _buildDivider(),
                      _buildDataRow('invoiceAmount:'.tr(), invoiceAmount,
                          fontWeight: pw.FontWeight.bold),
                    ],
                  )));
        },
      ),
    );

    // Save the PDF to a Uint8List
    final Uint8List pdfBytes = await pdf.save();

    // Get the app's documents directory
    final directory = await getApplicationDocumentsDirectory();

    // Save the Unit8List to a file in the documents directory
    final file = File('${directory.path}/invoice.pdf');
    await file.writeAsBytes(pdfBytes);
    return file; // Return the File object
  }

  pw.Widget _buildDataRow(String title, String data,
      {pw.FontWeight? fontWeight}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      // decoration: pw.BoxDecoration(
      //   border: pw.Border(
      //     bottom: pw.BorderSide(
      //       color: PdfColor.fromInt(0xFF000000),
      //     ),
      //   ),
      // ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title,
              style: pw.TextStyle(fontSize: 14, fontWeight: fontWeight)),
          pw.Text(data,
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  pw.Widget _buildDivider() {
    return pw.Container(
      margin: pw.EdgeInsets.symmetric(vertical: 8),
      height: 1,
      color: PdfColor.fromInt(0xFF000000),
    );
  }
}
