import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../../custom/app_button/app_button.dart';
import '../../../../../../../custom/app_textformfield/app_field.dart';
import '../../../../../../../custom/appbar/appbar.dart';
import '../../../../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../../../../custom/image/app_image_assets.dart';
import '../../../../../../../custom/sheet/show_bottom_sheet.dart';
import '../../../../../../../custom/text/app_text.dart';
import '../../../../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../../../../product/constants/image/image_constants.dart';
import '../../../../../../../product/utils/typography.dart';
import '../../../../../app_support/controller/app_support_controller.dart';
import '../../pending_tickets/controller/pending_ticket_controller.dart';
import '../../pending_tickets/model/reply_ticket_rquest_model.dart';
import '../controller/new_ticket_controller.dart';
import '../model/create_ticket_request_model.dart';

class NewTicketView extends StatefulWidget {
  const NewTicketView({super.key});

  @override
  State<NewTicketView> createState() => _NewTicketViewState();
}

class _NewTicketViewState extends State<NewTicketView> {
  final NewTicketController _newTicketController=Get.put(NewTicketController());



  @override
  void initState() {
    super.initState();
    _newTicketController.isReply=Get.arguments;

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        title: 'App Support',
        isTitleOnly: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                fieldView(),
                addAttachmentView(),
                const SizedBox(height: 100,),
                if (_newTicketController.isReply) footerReplyView() else footerView(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

//==============================================================================
// ** Main Widget **
//==============================================================================
  AppButton footerView(BuildContext context) {
    return AppButton(
        // ignore: avoid_bool_literals_in_conditional_expressions
        isDisable: _newTicketController.ticketType.text!='' && _newTicketController.descriptionController.text!='' && _newTicketController.attachments.isNotEmpty?false:true,
        title: 'Submit Your Ticket',
        onPressed: () async{
          if(_newTicketController.ticketType.text!='' && _newTicketController.descriptionController.text!='' && _newTicketController.attachments.isNotEmpty) {
            final bool success= await _newTicketController.createNewTicket(CreateTicketRequestModel(ticketType:_newTicketController.ticketType.text ,description:_newTicketController.descriptionController.text,attachments: _newTicketController.attachments ));
            if(success) {
              final AppSupportController appSupportController=Get.find();
              appSupportController.initialCount=true;
              appSupportController.isInitial.value=true;
              appSupportController.getTickets();

              // ignore: use_build_context_synchronously
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 30,
                  // here increase or decrease in width
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                builder: (BuildContext context) {
                  return SuccessFailsInfoDialog(
                    verticalPadding: 10,
                    title: 'Success',
                    buttonTitle: 'Done',
                    content: 'You have successfully submitted your ticket.',
                    tranId: _newTicketController.ticketId?.toString()??'',
                    isRouting: 'back',
                  );
                },
              );
            }
          }
        });
  }
  AppButton footerReplyView() {
    return AppButton(
      // ignore: avoid_bool_literals_in_conditional_expressions
        isDisable: _newTicketController.descriptionController.text!=''?false:true,
        title: 'Reply',
        onPressed: () async{
          if( _newTicketController.descriptionController.text!='' ) {
             final PendingTicketController pendingTicketController=Get.find();
             await pendingTicketController.replyChatTicket( ReplyTicketRequestModel(description:_newTicketController.descriptionController.text,attachments:_newTicketController.attachments  ) );
          }
        });
  }

  Column fieldView() {
    return Column(
      children: <Widget>[
       if(  !_newTicketController.isReply) AppTextFormField(
          title: 'Ticket Type',
          hintText: 'Select type',
          suffix: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          controller: _newTicketController.ticketType,
          onTap: () {
            bottomSheetDropDownList();
          },
          validate: (String? p0) {
            if (p0 == null || p0.isEmpty) {
              return 'Please Select Your City';
            }
            return null;
          },
          readOnly: true,
        ),
         AppTextFormField(
          contentPadding: const EdgeInsets.only(top: 15, left: 15),
          maxLines: 3,
          title: 'Ticket Description',
          hintText: 'Enter description',
          controller: _newTicketController.descriptionController,
           onChanged: (v){
            setState(() {

            });
           },
        )
      ],
    );
  }

  Padding addAttachmentView() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: () {
          pickDocument();
        },
        child: DottedBorder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            borderType: BorderType.RRect,
            radius: const Radius.circular(15),
            color: AppColors.appBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: _newTicketController.attachments.isNotEmpty ?80.0:0.0,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_,i)=> const SizedBox(width: 10,),
                   itemCount: _newTicketController.attachments.length,
                    itemBuilder: (_,int index)=>Align(
                      child: addAttachmentImage(
                          image: _newTicketController.attachments[index],
                          onClose: () {
                            setState(() {
                              _newTicketController.attachments.removeAt(index);
                            });
                          }),
                    ),
                  ),
                ),
                if (_newTicketController.attachments.length<=2) Padding(
                    padding: EdgeInsets.only(
                        top:
                        _newTicketController.attachments.isEmpty ? 0 : 15),
                    child: Column(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: AppImageAsset(
                            image: ImageConstants.clip,
                          ),
                        ),
                        Center(
                            child: Text(
                              _newTicketController.attachments.isEmpty ? 'Add More' : 'Add Attachment',
                          style: openSans.get14.w500.appBlue,
                        )),
                      ],
                    ),
                  ) else Padding(
                  padding: EdgeInsets.only(
                      top:
                      _newTicketController.attachments.isEmpty ? 0 : 15),
                    child:  SizedBox(width: 1000.px,
                    height: 10,),
                  ),
              ],
            )),
      ),
    );
  }

  Future<void> pickDocument() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['pdf', 'png', 'jpeg', 'jpg'],
    );
    if (result != null) {
        setState(() {
          _newTicketController.attachments.add(File(result.files.single.path ?? ''));
        });

    }
  }

  Widget addAttachmentImage(
      {required File image, required void Function() onClose}) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppColors.appBorderColor.withOpacity(0.5))),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ))),
          Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: onClose,
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: AppColors.downArrowColor.withOpacity(0.15),
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                    )),
              ))
        ],
      ),
    );
  }

  void bottomSheetDropDownList() {
    return showCommonBottomSheet(
        context: context,
        showDragHandle: false,
        commonWidget: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10),
                      child: Row(children: [
                        const Spacer(flex: 2,),
                        const AppText('Ticket Type',
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: AppColors.appTextColor),
                        const Spacer(flex: 1,),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 80),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.downArrowColor
                                      .withOpacity(0.15)),
                              child: const Padding(
                                padding: EdgeInsets.all(3),
                                child: Icon(Icons.close),
                              ),
                            ),
                          ),
                        ),
                      ],),
                    )

                  ,
                    Obx(()=>
                     ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _newTicketController.masterData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              _newTicketController.ticketType.text = _newTicketController.masterData[index];
                              Navigator.pop(context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 7),
                                  child: Text(_newTicketController.masterData[index],
                                      style: openSans.get16.w400.black),
                                ),
                                Divider(
                                  color:
                                      AppColors.appBorderColor.withOpacity(0.5),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
            );
          },
        ));
  }
}
