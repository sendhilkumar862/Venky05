import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../custom/app_button/app_button.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/dialog/success_fail_dialog.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/utils/typography.dart';

class ReUploadDocument extends StatefulWidget {
  const ReUploadDocument({Key? key}) : super(key: key);

  @override
  State<ReUploadDocument> createState() => _ReUploadDocumentState();
}

class _ReUploadDocumentState extends State<ReUploadDocument> {
  File? firstImage;
  File? secondImage;
  bool isSwitch=false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: HessaAppBar(
        isTitleOnly: true,
        // isBack: true,
        trailingText: 'Cancel',
        title: 'Complete Profile',
        // normalAppbar: true,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text('Upload Needed Files',
                        style:
                        openSans.get20.w700.textColor(AppColors.appTextColor)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
                    child: Text('Certificates',
                        style: openSans.get12.w400
                            .textColor(AppColors.appTextColor.withOpacity(0.5))),
                  ),
                  Center(
                    child: SizedBox(
                      width: width * 0.89,
                      child: InkWell(
                        onTap: ()  {
                          pickDocument();
                        },
                        child: DottedBorder(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(15),
                            color: AppColors.appBlue,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    if( firstImage != null)
                                      SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: Stack(
                                          children: [
                                            Container(
                                                decoration : BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(color: AppColors.appBorderColor.withOpacity(0.5))

                                                ),
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(12),
                                                    child: Image.file(firstImage!,width: 80,height:80 ,fit: BoxFit.cover,))),
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      firstImage = null;
                                                    });
                                                  },
                                                  child: Container(
                                                      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                      padding: EdgeInsets.all(3),
                                                      decoration: BoxDecoration(
                                                          color: AppColors.downArrowColor.withOpacity(0.15),
                                                          shape: BoxShape.circle
                                                      ),
                                                      child: Icon(Icons.close,size: 20,)),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    if( secondImage != null)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: Stack(
                                            children: [
                                              Container(
                                                  decoration : BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      border: Border.all(color: AppColors.appBorderColor.withOpacity(0.5))

                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(12),
                                                      child: Image.file(secondImage!,width: 80,height:80 ,fit: BoxFit.cover,))),
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        secondImage = null;
                                                      });
                                                    },
                                                    child: Container(
                                                        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                        padding: EdgeInsets.all(3),
                                                        decoration: BoxDecoration(
                                                            color: AppColors.downArrowColor.withOpacity(0.15),
                                                            shape: BoxShape.circle
                                                        ),
                                                        child: Icon(Icons.close,size: 20,)),
                                                  )
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                if(secondImage == null || firstImage == null) Padding(
                                  padding:  EdgeInsets.only( top:secondImage == null && firstImage == null ? 0: 15),
                                  child: Column(
                                    children: <Widget>[
                                      const Icon(Icons.cloud_upload_outlined,
                                          color: AppColors.appBlue),
                                      Center(
                                          child: Text(
                                            firstImage != null? 'Add More':'Upload Civil ID',
                                            style: openSans.get14.w500.appBlue,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 25),
                    child: Row(
                      children: <Widget>[
                        Text('Make it visible for users',
                            style: openSans.get14.w500
                                .textColor(AppColors.appTextColor)),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: FlutterSwitch(
                            value: isSwitch,
                            height: 16.29,
                            width: 27.63,
                            toggleSize: 12,
                            activeColor: AppColors.appBlue,
                            inactiveColor: AppColors.gray.withOpacity(0.25),
                            onToggle: (bool value) {
                              setState(() {
                                isSwitch = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppButton(title: 'Continue To Last Step',
                onPressed: (){
                  successBottomSheet(context);
                }
            )
          ],
        ),
      ),
    );
  }
  Future<void> pickDocument() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['pdf', 'png', 'jpeg', 'jpg'],
    );
    if (result != null) {
      if(firstImage == null) {
        setState(() {
          firstImage = File(result.files.single.path ?? '');
        });
      }else{
        setState(() {
          secondImage = File(result.files.single.path ?? '');
        });
      }
    }
  }
  Future<void> successBottomSheet(BuildContext context){
    return showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxWidth:
        MediaQuery.of(context).size.width -
            30,
        // here increase or decrease in width
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (BuildContext context) {
        return SuccessFailsInfoDialog(
          title: 'Success',
          buttonTitle: 'Done',
          content:
          "You have successfully submitted the needed files.\n\nOnce approved, you'll be ready to commence teaching.\n\nWe'll notify you soon!.",
        );
      },
    );
  }
}
