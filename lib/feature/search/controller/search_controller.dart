import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/routes/route.dart';
import '../../../core/api_end_points.dart';
import '../../../core/base_response.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../home/model/getClassList.dart';
import '../../preference/controller/preference_controller.dart';
import '../repository/get_seved_search_repository.dart';
import '../repository/search_repository.dart';



class SearchClassController extends GetxController {

  final PreferenceController preferenceController= Get.put(PreferenceController());
  final GetSavedSearchRepository _getSavedSearchRepository=GetSavedSearchRepository();
  final SearchRepository _searchRepository =SearchRepository();


  RxString error=''.obs;
  Set<String> selectedSchoolIndices = <String>{};
  Set<String> selectedCurriculumIndices = <String>{};
  Set<String> grade = <String>{};
  Set<String> selectedSubjectIndices = <String>{};
  String selectedSaveDataIndices = '';
  bool isSwitch = false;
  RxBool isSearch=false.obs;
  TextEditingController saveName = TextEditingController(text: '');


  RxList<GetClassListModel> searchClassList = <GetClassListModel>[].obs;
  RxList<String> savedData=<String>[].obs;


  Future<void> getSavedSearch(SchoolEndpoint schoolEndpoint) async {
    showLoading();
    final BaseResponse savedDataResponse =
    await _getSavedSearchRepository.getSavedSearchRepository(schoolEndpoint);
    if (savedDataResponse.status?.type == 'success') {
      searchClassList.clear();
      if(savedDataResponse.data!.item!=null){
        final List classListData=savedDataResponse.data!.item! as List;
        for (var element in classListData) {
          savedData.add(element);
        }}

    } else {
      error.value = savedDataResponse.status!.message!;
      AppUtils.showFlushBar(
        icon: Icons.check_circle_outline_rounded,
        iconColor: Colors.green,
        context: Routes.navigatorKey.currentContext!,
        message: error.value,
      );
    }
    hideLoading();
  }

  Future<void> search(SchoolEndpoint schoolEndpoint, Map<String, dynamic> searchData) async {
    showLoading();
    final BaseResponse classListDataResponse =
    await _searchRepository.searchRepository(schoolEndpoint, searchData);
    if (classListDataResponse.status?.type == 'success') {
      if(classListDataResponse.data!.item!=null){
      final List classListData=classListDataResponse.data!.item! as List;
      searchClassList.clear();
      for (var element in classListData) {
        searchClassList.add(GetClassListModel.fromJson(element));
      }}else{
        searchClassList.clear();
      }

    } else {
      error.value = classListDataResponse.status!.message!;
      AppUtils.showFlushBar(
        icon: Icons.check_circle_outline_rounded,
        iconColor: Colors.green,
        context: Routes.navigatorKey.currentContext!,
        message: error.value,
      );
    }
    isSearch.value=true;
    hideLoading();
  }

}
