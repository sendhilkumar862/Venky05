import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
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
        trailingTap: () =>
            Get.offAndToNamed(Routes.HomeScreenRoute),
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
              Obx(()=>
                  Center(
                    child: SizedBox(
                      width: width * 0.89,
                      child: InkWell(
                        onTap: () {
                          _personalInfoController.pickDocument();
                        },
                        child: DottedBorder(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(15),
                            color: AppColors.appBlue,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: _personalInfoController.imageFile.isNotEmpty?80:0,
                                  child: Align(
                                    child: ListView.separated(
                                      separatorBuilder: (_,i){
                                        return const SizedBox(width: 10,);
                                      },
                                      itemCount: _personalInfoController.imageFile.length,
                                      scrollDirection: Axis.horizontal,
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (_,int index){
                                        final File mediaFile= _personalInfoController.imageFile[index];
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
                                                    child:!mediaFile.path.contains('pdf')? Image.file(
                                                      mediaFile,
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                    ):PdfView(path: mediaFile.path),)),
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _personalInfoController.imageFile.removeAt(index);
                                                        _personalInfoController.civilIds.removeAt(index);
                                                      });
                                                    },
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
                                      },
                                    ),
                                  ),
                                ),
                                if (_personalInfoController.imageFile.length!=2)
                                  Padding(
                                    padding:
                                    EdgeInsets.only(top: _personalInfoController.imageFile.length!=2 ? 0 : 15),
                                    child: Column(
                                      children: <Widget>[
                                        const Icon(Icons.cloud_upload_outlined, color: AppColors.appBlue),
                                        Center(
                                            child: Text(
                                              _personalInfoController.imageFile.isNotEmpty ? 'Add More'
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
}
