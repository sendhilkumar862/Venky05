import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/app_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/utils/typography.dart';
import '../../personalInfo/controller/personal_info_controllere.dart';
import '../controller/experience_info_controller.dart';

class ExperienceInfo extends StatefulWidget {
  const ExperienceInfo({Key? key}) : super(key: key);

  @override
  State<ExperienceInfo> createState() => _ExperienceInfoState();
}

class _ExperienceInfoState extends State<ExperienceInfo> {
  final PersonalInfoController _personalInfoController =
      Get.put(PersonalInfoController());
  final ExperienceInfoController _experienceInfoController =
      Get.put(ExperienceInfoController());
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: HessaAppBar(
        isBack: true,
        trailingText: 'Cancel',
        title: 'Complete Profile',
        isTitleOnly: true,
        trailingTap: () => Navigator.popUntil(
            context, ModalRoute.withName(Routes.HomeScreenRoute)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text('Experience Information',
                    style:
                        openSans.get20.w700.textColor(AppColors.appTextColor)),
              ),
              AppTextFormField(
                title: 'Education',
                hintText: 'Enter your education',
                controller: _experienceInfoController.educationController,
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 30),
                child: Row(
                  children: <Widget>[
                    Text('Make it visible for users',
                        style: openSans.get14.w500
                            .textColor(AppColors.appTextColor)),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: FlutterSwitch(
                        value: _experienceInfoController.isSwitchEduction,
                        height: 16.29,
                        width: 27.63,
                        toggleSize: 12,
                        activeColor: AppColors.appBlue,
                        inactiveColor: AppColors.gray.withOpacity(0.25),
                        onToggle: (bool value) {
                          setState(() {
                            _experienceInfoController.isSwitchEduction = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              AppTextFormField(
                top: 0,
                title: 'Experience Years',
                hintText: 'Enter years of experience',
                controller: _experienceInfoController.experienceYearController,
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              AppTextFormField(
                maxLines: 3,
                title: 'Experience Brief',
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Enter experience brief',
                controller: _experienceInfoController.experienceBriefController,
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: <Widget>[
                    Text('Make it visible for users',
                        style: openSans.get14.w500
                            .textColor(AppColors.appTextColor)),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: FlutterSwitch(
                        value: _experienceInfoController.isSwitchExperience,
                        height: 16.29,
                        width: 27.63,
                        toggleSize: 12,
                        activeColor: AppColors.appBlue,
                        inactiveColor: AppColors.gray.withOpacity(0.25),
                        onToggle: (bool value) {
                          setState(() {
                            _experienceInfoController.isSwitchExperience =
                                value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: Text(
                  'Certificates',
                  style: openSans.get12.w400
                      .textColor(AppColors.appTextColor.withOpacity(0.5)),
                ),
              ),
              Center(
                child: SizedBox(
                  width: width * 0.89,
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
                                if (_experienceInfoController.firstImage !=
                                    null)
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
                                                  _experienceInfoController
                                                      .firstImage!,
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ))),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _experienceInfoController
                                                      .firstImage = null;
                                                });
                                              },
                                              child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .downArrowColor
                                                          .withOpacity(0.15),
                                                      shape: BoxShape.circle),
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 20,
                                                  )),
                                            ))
                                      ],
                                    ),
                                  ),
                                if (_experienceInfoController.secondImage !=
                                    null)
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
                                                    _experienceInfoController
                                                        .secondImage!,
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.cover,
                                                  ))),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _experienceInfoController
                                                        .secondImage = null;
                                                  });
                                                },
                                                child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .downArrowColor
                                                            .withOpacity(0.15),
                                                        shape: BoxShape.circle),
                                                    child: const Icon(
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
                            if (_experienceInfoController.secondImage == null ||
                                _experienceInfoController.firstImage == null)
                              Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        _experienceInfoController.secondImage ==
                                                    null &&
                                                _experienceInfoController
                                                        .firstImage ==
                                                    null
                                            ? 0
                                            : 15),
                                child: Column(
                                  children: <Widget>[
                                    const Icon(Icons.cloud_upload_outlined,
                                        color: AppColors.appBlue),
                                    Center(
                                        child: Text(
                                      _experienceInfoController.firstImage !=
                                              null
                                          ? 'Add More'
                                          : 'upload certificate',
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
                        value: _experienceInfoController.isSwitchCertificates,
                        height: 16.29,
                        width: 27.63,
                        toggleSize: 12,
                        activeColor: AppColors.appBlue,
                        inactiveColor: AppColors.gray.withOpacity(0.25),
                        onToggle: (bool value) {
                          setState(() {
                            _experienceInfoController.isSwitchCertificates =
                                value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              AppButton(
                  title: 'Continue To Teaching Information',
                  onPressed: () {
                    if (_experienceInfoController
                            .experienceYearController.text.isNotEmpty &&
                        _experienceInfoController
                            .educationController.text.isNotEmpty &&
                        _experienceInfoController
                            .experienceBriefController.text.isNotEmpty) {
                      _experienceInfoController.experienceInformationUpdate();
                    }
                  },
                  isDisable: _experienceInfoController
                              .experienceYearController.text.isNotEmpty &&
                          _experienceInfoController
                              .educationController.text.isNotEmpty &&
                          _experienceInfoController
                              .experienceBriefController.text.isNotEmpty
                      ? false
                      : true),
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
      _personalInfoController.uploadDocument(result.files.single.path ?? '');
      if (_experienceInfoController.firstImage == null) {
        setState(() {
          _experienceInfoController.firstImage =
              File(result.files.single.path ?? '');
        });
      } else {
        setState(() {
          _experienceInfoController.secondImage =
              File(result.files.single.path ?? '');
        });
      }
    }
  }
}
