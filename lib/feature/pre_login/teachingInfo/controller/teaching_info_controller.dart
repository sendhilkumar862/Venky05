
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' ;
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/api_end_points.dart';
import '../../../../core/base_response.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../home/controller/home_controller.dart';
import '../model/teacher_info_update_model_request.dart';
import '../model/teaching_info_helpers_repository.dart';
import '../repository/update_teaching_info_repository.dart';

class TeachingInfoController extends GetxController{
  RxList<String> selectedGrade = <String>[].obs;
  RxList<String> selectedSubject = <String>[].obs;
  RxList<String> selectedSchoolType =<String>[].obs;
  RxList<String> selectedCurriculum = <String>[].obs;
  RxList<String> selectedClassType = <String>[].obs;
  final HelpersRepository _helpersRepository=HelpersRepository();

  TextEditingController gradeController = TextEditingController();

  TextEditingController subjectController = TextEditingController();

  TextEditingController schoolController = TextEditingController();

  TextEditingController curriculumController = TextEditingController();

  TextEditingController classTypeController = TextEditingController();
  final TeachingInfoUpdateRepository _teachingInfoUpdateRepository=TeachingInfoUpdateRepository();

  List<String> gradeList = <String>[];
  List<String> subjectList = <String>[];
  List<String> schoolTypeList = <String>[];
  List<String> classTypeList = <String>[];
  List<String> curriculumTypeList = <String>[];
  void addGrade(String item) {
      if (selectedGrade.contains(item)) {
        selectedGrade.remove(item);
      } else {
        selectedGrade.add(item);
      }
  }

  void addSubject(String item) {

      if (selectedSubject.contains(item)) {
        selectedSubject.remove(item);
      } else {
        selectedSubject.add(item);
      }

  }

  void addSchoolType(String item) {

      if (selectedSchoolType.contains(item)) {
        selectedSchoolType.remove(item);
      } else {
        selectedSchoolType.add(item);
      }

  }

  void addCurriculum(String item) {

      if (selectedCurriculum.contains(item)) {
        selectedCurriculum.remove(item);
      } else {
        selectedCurriculum.add(item);
      }

  }

  void addClassType(String item) {

      if (selectedClassType.contains(item)) {
        selectedClassType.remove(item);
      } else {
        selectedClassType.add(item);
      }

  }

  String listToCommaSeparatedString(List<String> list) {
    String commaSeparatedString;
    return commaSeparatedString = list.join(', ');
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  fetchData()async{
    showLoading();
    await Future.wait([
      helpers(SchoolEndpoint.GRADES),
      helpers(SchoolEndpoint.TYPES),
      helpers(SchoolEndpoint.SUBJECTS),
      helpers(SchoolEndpoint.CLASS_TYPE),
      helpers(SchoolEndpoint.CURRICULUM),
    ]);
    EasyLoading.dismiss();
  }
  Future<void> helpers(SchoolEndpoint schoolEndpoint) async {
    final BaseResponse helperData = await _helpersRepository.getHelpers(schoolEndpoint);
    if (helperData.status?.type == 'success') {
      final List baseResponse = helperData.data?.item as List ;
      if(schoolEndpoint==SchoolEndpoint.CLASS_TYPE){
        classTypeList.clear();
        for (var element in baseResponse) {
          classTypeList.add(element);
        }
      }else if(schoolEndpoint==SchoolEndpoint.CURRICULUM){
        curriculumTypeList.clear();
        for (var element in baseResponse) {
          curriculumTypeList.add(element);
        }
      }
      else if(schoolEndpoint==SchoolEndpoint.TYPES){
        schoolTypeList.clear();
        for (var element in baseResponse) {
          schoolTypeList.add(element);
        }

      }
      else if(schoolEndpoint==SchoolEndpoint.SUBJECTS){
        subjectList.clear();
        for (var element in baseResponse) {
          subjectList.add(element);
        }
      }
      else if(schoolEndpoint==SchoolEndpoint.GRADES){
        gradeList.clear();
        for (var element in baseResponse) {
          gradeList.add(element);
        }
      }
    }else {
      EasyLoading.dismiss();
    }
  }


  Future<void> teachingInformationUpdate() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse personalUpdate = await _teachingInfoUpdateRepository.updateTeachingInfo(TeacherInfoUpdateRequest(grades:selectedGrade.toList(),subjects:selectedSubject.toList(),schoolTypes:selectedSchoolType.toList(),classTypes: selectedClassType.toList(),curriculum: selectedCurriculum.toList()));
    if (personalUpdate.status?.type == 'success') {
      final HomeController _home=Get.find();
      _home.fetchData();
      EasyLoading.dismiss();
      AppRouter.pushNamed(Routes.experienceInfo);
    }else {
      EasyLoading.dismiss();
    }
  }
}
