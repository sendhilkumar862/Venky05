import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../config/routes/route.dart';
import '../../../../core/base_response.dart';
import '../../../home/controller/home_controller.dart';
import '../../personalInfo/controller/personal_info_controllere.dart';
import '../model/experience_info_model_request.dart';
import '../repository/update_experience_info_repository.dart';

class ExperienceInfoController extends GetxController{
  final PersonalInfoController _personalInfoController= Get.put(PersonalInfoController());

  File? firstImage;
  File? secondImage;
  bool isSwitchEduction = false;
  bool isSwitchExperience = false;
  bool isSwitchCertificates = false;
  final ExperienceInfoUpdateRepository _experienceInfoUpdateRepository = ExperienceInfoUpdateRepository();
  TextEditingController educationController = TextEditingController();

  TextEditingController experienceYearController = TextEditingController();

  TextEditingController experienceBriefController = TextEditingController();

  Future<void> experienceInformationUpdate() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse personalUpdate = await _experienceInfoUpdateRepository.updateExperienceInfo(ExperienceInfoUpdateRequest(education:educationController.text,educationIsPublic:isSwitchEduction,experience:int.parse(experienceYearController.text),experienceDetails: experienceBriefController.text,experienceIsPublic:isSwitchExperience,certificateIds: _personalInfoController.civilIds,certificateIsPublic: isSwitchCertificates));
    if (personalUpdate.status?.type == 'success') {
      _personalInfoController.civilIds.clear();
      _personalInfoController.imageFile.clear();
      final HomeController home=Get.find();
      home.fetchData();
      EasyLoading.dismiss();
      Get.toNamed(Routes.financingView);
    }else {
      EasyLoading.dismiss();
    }
  }
}
