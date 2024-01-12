import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../custom/appbar/appbar.dart';
import '../../../../../custom/cardView/status_card_view.dart';
import '../../../../../custom/cardView/warning_card_view.dart';
import '../../../../../custom/image/app_image_assets.dart';
import '../../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../../product/extension/string_extension.dart';
import '../../../../../product/utils/typography.dart';
import '../../../app_support/controller/app_support_controller.dart';

class PendingTickets extends StatefulWidget {
  const PendingTickets({super.key});

  @override
  State<PendingTickets> createState() => _PendingTicketsState();
}

class _PendingTicketsState extends State<PendingTickets> {
  final AppSupportController _appSupportController = Get.find();
  List<TicketInfo> ticketInfoList = [
    TicketInfo(title: 'Ticket Date', data: '12/10/2023'),
    TicketInfo(title: 'Ticket Number', data: '#232132'),
    TicketInfo(title: 'Ticket Type', data: "Can't Create Class"),
    TicketInfo(
      title: 'Transaction State',
      status: StatusCardView(status: 'NEW'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        title: 'App Support',
        isTitleOnly: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: AppColors.appBorderColor.withOpacity(0.5)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                            'Ticket Date',
                          style: openSans.get12.w500.textColor(
                              AppColors.appTextColor
                                  .withOpacity(0.5)),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          _appSupportController.getTicketsList[_appSupportController.appSupportDetailIndex].createdAt.toString().epochToDate(),
                          style: openSans.get16.w500.appTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                  'Ticket Number',
                                style: openSans.get12.w500.textColor(
                                    AppColors.appTextColor
                                        .withOpacity(0.5)),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                _appSupportController.getTicketsList[_appSupportController.appSupportDetailIndex].ticketId.toString(),
                                style: openSans.get16.w500.appTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                  'Ticket Type',
                                style: openSans.get12.w500.textColor(
                                    AppColors.appTextColor
                                        .withOpacity(0.5)),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                _appSupportController.getTicketsList[_appSupportController.appSupportDetailIndex].ticketId.toString(),
                                style: openSans.get16.w500.appTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Transaction State',
                                style: openSans.get12.w500.textColor(
                                    AppColors.appTextColor
                                        .withOpacity(0.5)),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: StatusCardView(status:    _appSupportController.getTicketsList[_appSupportController.appSupportDetailIndex].status??'',),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: AppColors.appBorderColor.withOpacity(0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Text(
                        'Ticket Description',
                        style: openSans.get12.w500
                            .textColor(AppColors.appTextColor.withOpacity(0.5)),
                      ),
                    ),
                    Text(
                      _appSupportController.getTicketsList[_appSupportController.appSupportDetailIndex].description??'',
                      style: openSans.get16.w400,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        height: 1,
                        color: AppColors.appBorderColor.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      'Attachments',
                      style: openSans.get12.w500
                          .textColor(AppColors.appTextColor.withOpacity(0.5)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        width: 500,
                        height: 100,
                        child: ListView.separated(
                          separatorBuilder: (_,i){
                            return const SizedBox(width: 10,);
                          },
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount:  _appSupportController.getTicketsList[_appSupportController.appSupportDetailIndex].attachments?.length??0,
                          itemBuilder:(BuildContext context, int index) {
                            return Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.67),
                                  border: Border.all(
                                    color: AppColors.appBorderColor.withOpacity(0.5),
                                  )),
                              child: AppImageAsset(
                                image: _appSupportController.getTicketsList[_appSupportController.appSupportDetailIndex].attachments![index].attachmentId!.getAttachmentUrl(_appSupportController.getTicketsList[_appSupportController.appSupportDetailIndex].ticketId.toString()),
                                fit: BoxFit.fill,
                              ),
                            );
                          }
                        ),
                      ),
                    )
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: WarningCardView(error: 'No replies yet from Hessah'),
          ),
        ]),
      ),
    );
  }
}

class TicketInfo {
  TicketInfo({
    required this.title,
    this.data,
    this.status,
  });

  final String title;
  final String? data;
  final StatusCardView? status;
}
