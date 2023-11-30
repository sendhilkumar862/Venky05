import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../custom/app_button/app_button.dart';
import '../../../../../custom/app_textformfield/app_field.dart';
import '../../../../../custom/appbar/appbar.dart';
import '../../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../../custom/image/app_image_assets.dart';
import '../../../../../custom/sheet/show_bottom_sheet.dart';
import '../../../../../custom/text/app_text.dart';
import '../../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../../product/constants/image/image_constants.dart';
import '../../../../../product/utils/typography.dart';

class NewTicketView extends StatefulWidget {
  const NewTicketView({super.key});

  @override
  State<NewTicketView> createState() => _NewTicketViewState();
}

class _NewTicketViewState extends State<NewTicketView> {
//==============================================================================
// ** Properties **
//==============================================================================
  List ticketTypeList = [
    'General Inquiry',
    "Can't Create Class",
    'Problem About Booked Class',
    "Can't Book Class",
    'Problem With Teacher',
    'Refund Issue',
    'Top Up Issue',
    'Problem About Account Settings',
  ];
  File? firstImage;
  File? secondImage;
  bool isSwitch = false;
  TextEditingController ticketType = TextEditingController();

//==============================================================================
// ** Life Cycle **
//==============================================================================
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
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  fieldView(),
                  addAttachmentView(),
                ],
              ),
            ),
            footerView(context)
          ],
        ),
      ),
    );
  }

//==============================================================================
// ** Main Widget **
//==============================================================================
  AppButton footerView(BuildContext context) {
    return AppButton(
        isDisable: false,
        title: 'Submit Your Ticket',
        onPressed: () {
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
                // onPressed: () {
                //   AppRouter.push(PendingTickets());
                // },
                verticalPadding: 10,
                title: 'Success',
                buttonTitle: 'Done',
                content: 'You have successfully submitted your ticket.',
                tranId: '#232132',
              );
            },
          );
        });
  }

  Column fieldView() {
    return Column(
      children: <Widget>[
        AppTextFormField(
          title: 'Ticket Type',
          hintText: 'Select type',
          suffix: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          controller: ticketType,
          onTap: () {
            bottomSheetDropDownList();
          },
          validate: (p0) {
            if (p0 == null || p0.isEmpty) {
              return 'Please Select Your City';
            }
            return null;
          },
          readOnly: true,
        ),
        const AppTextFormField(
          contentPadding: EdgeInsets.only(top: 15, left: 15),
          maxLines: 3,
          title: 'Ticket Description',
          hintText: 'Enter description',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (firstImage != null)
                      addAttachmentImage(
                          image: firstImage!,
                          onClose: () {
                            setState(() {
                              firstImage = null;
                            });
                          }),
                    if (secondImage != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: addAttachmentImage(
                            image: secondImage!,
                            onClose: () {
                              setState(() {
                                secondImage = null;
                              });
                            }),
                      ),
                  ],
                ),
                if (secondImage == null || firstImage == null)
                  Padding(
                    padding: EdgeInsets.only(
                        top:
                            secondImage == null && firstImage == null ? 0 : 15),
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
                          firstImage != null ? 'Add More' : 'Add Attachment',
                          style: openSans.get14.w500.appBlue,
                        )),
                      ],
                    ),
                  ),
              ],
            )),
      ),
    );
  }

//==============================================================================
// ** Helper Widget **
//==============================================================================
  Future<void> pickDocument() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['pdf', 'png', 'jpeg', 'jpg'],
    );
    if (result != null) {
      if (firstImage == null) {
        setState(() {
          firstImage = File(result.files.single.path ?? '');
        });
      } else {
        setState(() {
          secondImage = File(result.files.single.path ?? '');
        });
      }
    }
  }

  Widget addAttachmentImage(
      {required File image, required void Function() onClose}) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppColors.appBorderColor.withOpacity(0.5))),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    image!,
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
                    padding: EdgeInsets.all(3),
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
        commonWidget: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Align(
                            child: AppText('Ticket Type',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: AppColors.appTextColor),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
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
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ticketTypeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            ticketType.text = ticketTypeList[index];
                            Navigator.pop(context);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 7),
                                child: Text(ticketTypeList[index],
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
                  ]),
            );
          },
        ));
  }
}
