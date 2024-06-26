import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../config/routes/app_router.dart';
import '../../config/routes/routes.dart';
import '../../custom/app_button/app_button.dart';
import '../../custom/app_textformfield/app_field.dart';
import '../../custom/appbar/appbar.dart';
import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/utils/typography.dart';

class ExperienceInfo extends StatefulWidget {
  const ExperienceInfo({Key? key}) : super(key: key);

  @override
  State<ExperienceInfo> createState() => _ExperienceInfoState();
}

class _ExperienceInfoState extends State<ExperienceInfo> {
  File? firstImage;
  File? secondImage;
  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: HessaAppBar(
        trailingText: 'cancel'.tr(),
        title: 'completeProfile'.tr(),
        isTitleOnly: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text('experienceInformation'.tr(),
                    style:
                        openSans.get20.w700.textColor(AppColors.appTextColor)),
              ),
              AppTextFormField(
                title: 'education'.tr(),
                hintText: 'enterYourEducation'.tr(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 30),
                child: Row(
                  children: <Widget>[
                    Text('makeItVisibleForUsers'.tr(),
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
              AppTextFormField(
                top: 0,
                title: 'experienceYears'.tr(),
                hintText: 'enterYearsOExperience'.tr(),
              ),
              AppTextFormField(
                maxLines: 3,
                title: 'experienceBrief'.tr(),
                hintText: 'enterExperienceBrief'.tr(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: <Widget>[
                    Text('makeItVisibleForUsers'.tr(),
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
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: Text('certificates'.tr(),
                    style: openSans.get12.w400
                        .textColor(AppColors.appTextColor.withOpacity(0.5))),
              ),
              Center(
                child: SizedBox(
                  width: width * 0.89,
                  child: InkWell(
                    onTap: () {
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
                                if (firstImage != null)
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Stack(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: AppColors
                                                        .appBorderColor
                                                        .withOpacity(0.5))),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.file(
                                                  firstImage!,
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ))),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  firstImage = null;
                                                });
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .downArrowColor
                                                          .withOpacity(0.15),
                                                      shape: BoxShape.circle),
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 20,
                                                  )),
                                            ))
                                      ],
                                    ),
                                  ),
                                if (secondImage != null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Stack(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color: AppColors
                                                          .appBorderColor
                                                          .withOpacity(0.5))),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.file(
                                                    secondImage!,
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.cover,
                                                  ))),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    secondImage = null;
                                                  });
                                                },
                                                child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 5),
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .downArrowColor
                                                            .withOpacity(0.15),
                                                        shape: BoxShape.circle),
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 20,
                                                    )),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            if (secondImage == null || firstImage == null)
                              Padding(
                                padding: EdgeInsets.only(
                                    top: secondImage == null &&
                                            firstImage == null
                                        ? 0
                                        : 15),
                                child: Column(
                                  children: <Widget>[
                                    const Icon(Icons.cloud_upload_outlined,
                                        color: AppColors.appBlue),
                                    Center(
                                        child: Text(
                                      firstImage != null
                                          ? 'addMore'.tr()
                                          : 'uploadCivilID'.tr(),
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
                    Text('makeItVisibleForUsers'.tr(),
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
              AppButton(
                  title: 'continueToLastStep'.tr(),
                  onPressed: () {
                    AppRouter.pushNamed(Routes.financingView);
                  },
                  isDisable: false),
            ],
          ),
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
}
