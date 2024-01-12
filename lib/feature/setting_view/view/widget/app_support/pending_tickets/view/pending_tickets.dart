import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hessah/product/constants/image/image_constants.dart';
import '../../../../../../../custom/app_button/app_button.dart';
import '../../../../../../../custom/appbar/appbar.dart';
import '../../../../../../../custom/cardView/status_card_view.dart';
import '../../../../../../../custom/cardView/warning_card_view.dart';
import '../../../../../../../custom/image/app_image_assets.dart';
import '../../../../../../../custom/text/app_text.dart';
import '../../../../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../../../../product/extension/string_extension.dart';
import '../../../../../../../product/utils/typography.dart';
import '../../../../../app_support/controller/app_support_controller.dart';
import '../controller/pending_ticket_controller.dart';
import '../model/gte_chat_ticket_responce_model.dart';

class PendingTickets extends StatefulWidget {
  const PendingTickets({super.key});

  @override
  State<PendingTickets> createState() => _PendingTicketsState();
}

class _PendingTicketsState extends State<PendingTickets> {
  final AppSupportController _appSupportController = Get.find();
  final PendingTicketController _pendingTicketController=Get.put(PendingTicketController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        title: 'App Support',
        isTitleOnly: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      padding: const EdgeInsets.all(15),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        _appSupportController
                                            .getTicketsList[
                                                _appSupportController
                                                    .appSupportDetailIndex]
                                            .createdAt
                                            .toString()
                                            .epochToDate(),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        _appSupportController
                                            .getTicketsList[
                                                _appSupportController
                                                    .appSupportDetailIndex]
                                            .ticketId
                                            .toString(),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        _appSupportController
                                            .getTicketsList[
                                                _appSupportController
                                                    .appSupportDetailIndex]
                                            .ticketId
                                            .toString(),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: StatusCardView(
                                        status: _appSupportController
                                                .getTicketsList[
                                                    _appSupportController
                                                        .appSupportDetailIndex]
                                                .status ??
                                            '',
                                      ),
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
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text(
                                'Ticket Description',
                                style: openSans.get12.w500.textColor(
                                    AppColors.appTextColor.withOpacity(0.5)),
                              ),
                            ),
                            Text(
                              _appSupportController
                                      .getTicketsList[_appSupportController
                                          .appSupportDetailIndex]
                                      .description ??
                                  '',
                              style: openSans.get16.w400,
                            ),
                            if(_appSupportController
                                .getTicketsList[
                            _appSupportController
                                .appSupportDetailIndex].attachments!.isNotEmpty)attachments(_appSupportController
                                .getTicketsList[
                            _appSupportController
                                .appSupportDetailIndex].attachments!),
                          ]),
                    ),
                  ),

                  Obx(()=>
                     Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _pendingTicketController.chatMessage.length,
                        itemBuilder: (_, int index){
                          return _pendingTicketController.chatMessage[index].isAdminReply==0? youReplied( _pendingTicketController.chatMessage[index]):hessaReplyMessage( _pendingTicketController.chatMessage[index]);
                        },

                      ),
                    ),
                  ),


                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.appPurple),
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.appPurple),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppImageAsset(
                              color: AppColors.appWhite,
                              image: ImageConstants.replyMessage,
                              height: 30,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Send Reply',
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AppButton(
                  isDisable: false,
                  title: 'Mark Ticket As Solved',
                  onPressed: () {}),
            ),
            const AppText(
              'Cancel Ticket',
              color: AppColors.appBlue,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
  Widget hessaReplyMessage( ChatTicketResponseModel chatTicketResponseModel){
    return  SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: WarningCardView(error: 'No replies yet from Hessah'),
          ),
          const Row(
            children: [
              AppImageAsset(
                  image: ImageConstants.replyHessahIcon, height: 40),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: AppText(
                  'Hessah',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: AppColors.appBorderColor.withOpacity(0.5)),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Reply on ${chatTicketResponseModel.createdAt.toString().epochToDate()}',
                      style: openSans.get12.w500.textColor(
                          AppColors.appTextColor.withOpacity(0.5)),
                    ),
                  ),
                  Text(
                    chatTicketResponseModel.message??'',
                    style: openSans.get16.w400,
                  ),
                  if(chatTicketResponseModel.attachments!.isNotEmpty)attachments(chatTicketResponseModel.attachments!)
                ]),
          ),
        ],
      ),
    );
  }
  Widget youReplied(ChatTicketResponseModel chatTicketResponseModel){
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: AppText(
                'You',
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            Container(
              height: 28,
              decoration:
              const BoxDecoration(shape: BoxShape.circle),
              child: const AppImageAsset(
                  image: ImageConstants.teacherAvtar),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: AppColors.appBorderColor.withOpacity(0.5)),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Reply on ${chatTicketResponseModel.createdAt.toString().epochToDate()}',
                    style: openSans.get12.w500.textColor(
                        AppColors.appTextColor.withOpacity(0.5)),
                  ),
                ),
                Text(
                  chatTicketResponseModel.message??'',
                  style: openSans.get16.w400,
                ),
                if(chatTicketResponseModel.attachments!.isNotEmpty)attachments(chatTicketResponseModel.attachments!)
              ]),
        ),
      ),
    ],);
  }
  Widget attachments(List<Attachment> attachments){
    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(
            height: 1,
            color:
            AppColors.appBorderColor.withOpacity(0.5),
          ),
        ),
        Text(
          'Attachments',
          style: openSans.get12.w500.textColor(
              AppColors.appTextColor.withOpacity(0.5)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: SizedBox(
            width: 500,
            height: 100,
            child: ListView.separated(
                separatorBuilder: (_, i) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: attachments.length,
                itemBuilder:
                    (BuildContext context, int index) {
                  return Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(6.67),
                        border: Border.all(
                          color: AppColors.appBorderColor
                              .withOpacity(0.5),
                        )),
                    child: AppImageAsset(
                      image: attachments[index].attachmentId!
                          .getAttachmentUrl(
                          attachments[index].attachmentId!),
                      fit: BoxFit.fill,
                    ),
                  );
                }),
          ),
        ),
      ],);
  }
}



