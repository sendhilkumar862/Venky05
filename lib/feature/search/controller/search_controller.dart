import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/routes/route.dart';
import '../../../core/api_end_points.dart';
import '../../../core/base_response.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../home/model/getClassList.dart';
import '../../home/model/user_search_model.dart';
import '../../preference/controller/preference_controller.dart';
import '../repository/get_seved_search_repository.dart';
import '../repository/search_repository.dart';



class SearchClassController extends GetxController {

  final PreferenceController preferenceController= Get.put(PreferenceController());
  final GetSavedSearchRepository _getSavedSearchRepository=GetSavedSearchRepository();
  final SearchRepository _searchRepository =SearchRepository();

// class variable
  RxString error=''.obs;
  Set<String> selectedSchoolIndices = <String>{};
  Set<String> selectedCurriculumIndices = <String>{};
  Set<String> grade = <String>{};
  Set<String> selectedSubjectIndices = <String>{};
  String selectedSaveDataIndices = '';
  bool isSwitch = false;
  RxBool isSearch=false.obs;
  TextEditingController saveName = TextEditingController(text: '');



  //user variable
  Set<String> selectedSchoolIndicesUser = <String>{};
  Set<String> gradeUser = <String>{};
  Set<String> selectedSubjectIndicesUser = <String>{};
  Set<String> selectedGenderIndices = <String>{};
  Set<String> selectedCurriculumIndicesUser = <String>{};
  bool isSwitchUser = false;
  RxBool isSearchUser=false.obs;
  String selectedSaveDataIndicesUser = '';
  TextEditingController saveNameUser = TextEditingController(text: '');
  List<String> genderList = <String>[
    'Male',
    'Female',
  ];


  RxList<GetClassListModel> searchClassList = <GetClassListModel>[].obs;
  RxList<UserSearchModel> searchClassListUser = <UserSearchModel>[].obs;
  RxList<String> savedData=<String>[].obs;
  RxList<String> savedDataUser=<String>[].obs;


  Future<void> getSavedSearch(SchoolEndpoint schoolEndpoint) async {
    showLoading();
    final BaseResponse savedDataResponse =
    await _getSavedSearchRepository.getSavedSearchRepository(schoolEndpoint);
    if (savedDataResponse.status?.type == 'success') {
      if(schoolEndpoint==SchoolEndpoint.GET_SEARCH_CLASS){
        savedData.clear();
      if(savedDataResponse.data!.item!=null){
        final List classListData=savedDataResponse.data!.item! as List;
        for (var element in classListData) {
          savedData.add(element);
        }}}else{
        savedDataUser.clear();
        if(savedDataResponse.data!.item!=null){
          final List classListData=savedDataResponse.data!.item! as List;
          for (var element in classListData) {
            savedDataUser.add(element);
          }}
      }

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
      if(schoolEndpoint==SchoolEndpoint.SEARCH_CLASSES){
        searchClassList.clear();
        if(classListDataResponse.data!.item!=null){
          final List classListData=classListDataResponse.data!.item! as List;
      for (var element in classListData) {
        searchClassList.add(GetClassListModel.fromJson(element));
      }}
        isSearch.value=true;}else{
        searchClassListUser.clear();
        if(classListDataResponse.data!.item!=null){
          final List classListData=classListDataResponse.data!.item! as List;
          for (var element in classListData) {
            searchClassListUser.add(UserSearchModel.fromJson(element));
          }}
        isSearchUser.value=true;
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
    hideLoading();
  }

}
