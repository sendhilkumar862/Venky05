import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../../../config/routes/app_router.dart';
import '../../../core/base_response.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../../tutorial/model/response_model/response_model.dart';
import '../model/preference_model.dart';
import '../model/preference_request.dart';
import '../repository/get_user_reference_repository.dart';
import '../repository/set_user_preference_repository.dart';

class PreferenceController extends GetxController{

  RxList<String> selectedGrade = <String>[].obs;


  RxList<String> selectedSchool = <String>[].obs;


  RxList<String> selectedSchoolIndices = <String>[].obs;


  RxList<String> selectedCurriculumIndices = <String>[].obs;


  RxList<String> selectedSubjectIndices = <String>[].obs;


  RxList<Grade> grade=<Grade>[].obs ;


  RxList<Grade> schoolType=<Grade>[].obs ;


  RxList<Grade> curriculum=<Grade>[].obs ;


  RxList<Grade> subject =<Grade>[].obs ;


  Rx<PreferenceModel> preferenceModel = PreferenceModel().obs;



  final GetUserPreferenceRepository _getUserPreferenceRepository=GetUserPreferenceRepository();
  final SetUserPreferenceRepository _setUserPreferenceRepository= SetUserPreferenceRepository();

  RxString errors = ''.obs;


  RxString setPreferenceErrors = ''.obs;


  @override
  void onInit() {
    super.onInit();
    getUserPreference();
  }

  Future<Options> _headers() async {
    final KeyValueStorageService keyValueStorageService =
    KeyValueStorageService();
    final String token = await keyValueStorageService.getAuthToken();
    print("get token ${token}");
    return Options(
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
    );
  }



  Future<void> getUserPreference() async {
    showLoading();
    final BaseResponse preferenceData = await _getUserPreferenceRepository.getUserPreferenceRepository();
    if (preferenceData.status?.type == 'success') {
      hideLoading();
      preferenceModel.value = PreferenceModel.fromJson(preferenceData.data?.item as Map<String, dynamic>);
      grade.value = preferenceModel.value.grade ?? [];
      schoolType.value = preferenceModel.value.schoolType ?? [];
      curriculum.value = preferenceModel.value.curriculum ?? [];
      subject.value = preferenceModel.value.subject ?? [];
      setPreferenceData();
    }else {
      hideLoading();
      errors.value = preferenceData.status!.message!;
      AppUtils.showFlushBar(
        icon: Icons.check_circle_outline_rounded,
        iconColor: Colors.green,
        context: AppRouter.navigatorKey.currentContext!,
        message: errors.value ?? 'Error occured',
      );
    }
  }



  Future<void> setUserPreference() async {
    showLoading();
    final BaseResponse setpreferenceData = await _setUserPreferenceRepository.setUserPreferenceRepository(PreferenceRequest(
      grade: selectedGrade,
      schoolType: selectedSchoolIndices,
      curriculum: selectedCurriculumIndices,
      subject: selectedSubjectIndices,
    ));
    if (setpreferenceData.status?.type == 'success') {
      KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
      keyValueStorageBase.setCommon(
          KeyValueStorageService.setPreference, true);
      hideLoading();
    }else{
      hideLoading();
      setPreferenceErrors.value = setpreferenceData.status!.message!;
    }
  }

  void setPreferenceData() {
      for (int i = 0; i < grade!.length; i++) {
        if (grade![i].isEnabled ?? false) {
          selectedGrade.add(grade![i].value ?? '');
        }
      }
      for (int i = 0; i < schoolType!.length; i++) {
        if (schoolType![i].isEnabled ?? false) {
          selectedSchoolIndices.add(schoolType![i].value ?? '');
        }
      }
      for (int i = 0; i < curriculum!.length; i++) {
        if (curriculum![i].isEnabled ?? false) {
          selectedCurriculumIndices.add(curriculum![i].value ?? '');
        }
      }
      for (int i = 0; i < subject!.length; i++) {
        if (subject![i].isEnabled ?? false) {
          selectedSubjectIndices.add(subject![i].value ?? '');
        }
      }

  }
}
