import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hessah/feature/home/repository/model/getClassList.dart';
import 'package:hessah/feature/home/repository/model/teacher_search_model.dart';
import 'package:hessah/feature/home/repository/model/user_search_model.dart';

import '../../../config/routes/route.dart';
import '../../../core/api_end_points.dart';
import '../../../core/base_response.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../class/class_detail/controller/class_detail_controller.dart';

import '../repository/get_seved_search_repository.dart';
import '../repository/search_repository.dart';



class SearchClassController extends GetxController {

  final ClassDetailController preferenceController= Get.put(ClassDetailController());
  final GetSavedSearchRepository _getSavedSearchRepository=GetSavedSearchRepository();
  final SearchRepository _searchRepository =SearchRepository();

  int tabIndex=0;

// class variable
  RxString error=''.obs;
  Set<String> selectedSchoolIndices = <String>{};
  Set<String> selectedCurriculumIndices = <String>{};
  Set<String> grade = <String>{};
  Set<String> selectedSubjectIndices = <String>{};
  String selectedSaveDataIndices = '';
  String selectedGenderIndices = '';
  Set<String> selectedClassTypeIndices = <String>{};
  bool isSwitch = false;
  RxBool isSearch=false.obs;
  TextEditingController saveName = TextEditingController(text: '');
  int totalClassCount=0;
 ScrollController scrollControllerClass = ScrollController();
  late Map<String, dynamic>  searchData;
  int pageIndex=1;



  //user variable
  Set<String> selectedSchoolIndicesUser = <String>{};
  Set<String> gradeUser = <String>{};
  Set<String> selectedSubjectIndicesUser = <String>{};
  Set<String> selectedCurriculumIndicesUser = <String>{};
  bool isSwitchUser = false;
  RxBool isSearchUser=false.obs;
  String selectedSaveDataIndicesUser = '';
  TextEditingController saveNameUser = TextEditingController(text: '');
  int totalUserCount=0;
ScrollController scrollControllerUser = ScrollController();
  late Map<String, dynamic>  searchUserData;
  int pageUserIndex=1;


  RxList<GetClassListModel> searchClassList = <GetClassListModel>[].obs;
  RxList<UserSearchModel> searchClassListUser = <UserSearchModel>[].obs;
  RxList<TeacherSearchModel> searchClassListTeacher = <TeacherSearchModel>[].obs;

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

  Future<void> search(SchoolEndpoint schoolEndpoint, Map<String, dynamic> searchData, {bool reload=false}) async {
    showLoading();
    final BaseResponse classListDataResponse =
    await _searchRepository.searchRepository(schoolEndpoint, searchData);
    if (classListDataResponse.status?.type == 'success') {
      if(schoolEndpoint==SchoolEndpoint.SEARCH_CLASSES){
       if(!reload) {
         searchClassList.clear();
       }
        if(classListDataResponse.data!.item!=null){
          final List classListData=classListDataResponse.data!.item! as List;
      for (var element in classListData) {
        searchClassList.add(GetClassListModel.fromJson(element));
      }
          totalClassCount=classListDataResponse.paginationData?.total??0;}
        isSearch.value=true;}
      else if(schoolEndpoint==SchoolEndpoint.SEARCH_TUTORS){
        // ignore: always_put_control_body_on_new_line
        if(!reload) { searchClassListUser.clear();
        searchClassListTeacher.clear();
        }
        if(classListDataResponse.data!.item!=null){
          final List classListData=classListDataResponse.data!.item! as List;
          for (var element in classListData) {
            searchClassListTeacher.add(TeacherSearchModel.fromJson(element));
          }
          totalUserCount=classListDataResponse.paginationData?.total??0;}
        isSearchUser.value=true;
      }
      else{
        // ignore: always_put_control_body_on_new_line
        if(!reload) { searchClassListUser.clear();}
        if(classListDataResponse.data!.item!=null){
          final List classListData=classListDataResponse.data!.item! as List;
          for (var element in classListData) {
            searchClassListUser.add(UserSearchModel.fromJson(element));
          }
          totalUserCount=classListDataResponse.paginationData?.total??0;}
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
  Future<void> pagination({required SchoolEndpoint endPoint})async{
    if(searchClassList.length<totalClassCount && endPoint==SchoolEndpoint.SEARCH_CLASSES) {
      pageIndex=pageIndex+1;
      // ignore: avoid_dynamic_calls
      searchData['pagination']['pageIndex']=pageIndex;
      await search(endPoint,searchData,reload: true);
    }else if(searchClassListUser.length<totalUserCount && (endPoint==SchoolEndpoint.SEARCH_TUTORS || endPoint==SchoolEndpoint.SEARCH_STUDENTS)){
      pageUserIndex=pageUserIndex+1;
      // ignore: avoid_dynamic_calls
      searchUserData['pagination']['pageIndex']=pageUserIndex;
      await search(endPoint,searchUserData,reload: true);
    }
  }

}
