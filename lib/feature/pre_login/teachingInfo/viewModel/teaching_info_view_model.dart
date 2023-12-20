import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;
import 'package:mobx/mobx.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../../../home/controller/home_controller.dart';

part 'teaching_info_view_model.g.dart';

class TeachingInfoViewModel = _TeachingInfoViewModelBase
    with _$TeachingInfoViewModel;

abstract class _TeachingInfoViewModelBase extends BaseViewModel with Store {
  ObservableList<String> selectedGrade = ObservableList<String>();
  ObservableList<String> selectedSubject = ObservableList<String>();
  ObservableList<String> selectedSchoolType = ObservableList<String>();
  ObservableList<String> selectedCurriculum = ObservableList<String>();
  ObservableList<String> selectedClassType = ObservableList<String>();

  @observable
  TextEditingController gradeController = TextEditingController();
  @observable
  TextEditingController subjectController = TextEditingController();
  @observable
  TextEditingController schoolController = TextEditingController();
  @observable
  TextEditingController curriculumController = TextEditingController();
  @observable
  TextEditingController classTypeController = TextEditingController();
  @observable
  List<String> gradeList = <String>[];
  List<String> subjectList = <String>[];
  List<String> schoolTypeList = <String>[];
  List<String> classTypeList = <String>[];
  List<String> curriculumTypeList = <String>[];
  void addGrade(String item) {
    runInAction(() {
      if (selectedGrade.contains(item)) {
        selectedGrade.remove(item);
      } else {
        selectedGrade.add(item);
      }
    });
  }

  void addSubject(String item) {
    runInAction(() {
      if (selectedSubject.contains(item)) {
        selectedSubject.remove(item);
      } else {
        selectedSubject.add(item);
      }
    });
  }

  void addSchoolType(String item) {
    runInAction(() {
      if (selectedSchoolType.contains(item)) {
        selectedSchoolType.remove(item);
      } else {
        selectedSchoolType.add(item);
      }
    });
  }

  void addCurriculum(String item) {
    runInAction(() {
      if (selectedCurriculum.contains(item)) {
        selectedCurriculum.remove(item);
      } else {
        selectedCurriculum.add(item);
      }
    });
  }

  void addClassType(String item) {
    runInAction(() {
      if (selectedClassType.contains(item)) {
        selectedClassType.remove(item);
      } else {
        selectedClassType.add(item);
      }
    });
  }

  String listToCommaSeparatedString(List<String> list) {
    String commaSeparatedString;
    return commaSeparatedString = list.join(', ');
  }

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    fetchData();
  }

  fetchData()async{
    showLoading();
    await Future.wait([
      fetchGrade(),
      fetchSubjectTaught(),
      fetchSchoolType(),
      fetchCurriculum(),
      fetchTypeOfClass(),
    ]);
    EasyLoading.dismiss();
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
  Future<void> fetchGrade() async {
    final Dio dio = Dio();
    try {
      Response response = await dio.get('http://167.99.93.83/api/v1/school/grades',
        options: await _headers(),);

      logs('Status code--> ${response.statusCode}');

      if (response.statusCode == 200) {

        if(response.data['status']['type']=='success'){
          // ignore: always_specify_types
          final List baseResponse = response.data['data']['items'] ;
          gradeList.clear();
          for (var element in baseResponse) {
            gradeList.add(element);
          }}
      }
    } catch (error) {
      logs('Error: $error');
    }
  }
  Future<void> fetchSubjectTaught() async {
    final Dio dio = Dio();
    try {
      Response response = await dio.get('http://167.99.93.83/api/v1/school/subjects',
        options: await _headers(),);

      logs('Status code--> ${response.statusCode}');

      if (response.statusCode == 200) {

        if(response.data['status']['type']=='success'){
          // ignore: always_specify_types
          final List baseResponse = response.data['data']['items'] ;
          subjectList.clear();
          for (var element in baseResponse) {
            subjectList.add(element);
          }}

      }
    } catch (error) {

      logs('Error: $error');
    }
  }
  Future<void> fetchSchoolType() async {
    final Dio dio = Dio();
    try {
      Response response = await dio.get('http://167.99.93.83/api/v1/school/types',
        options: await _headers(),);

      logs('Status code--> ${response.statusCode}');

      if (response.statusCode == 200) {

        if(response.data['status']['type']=='success'){
          // ignore: always_specify_types
          final List baseResponse = response.data['data']['items'] ;
          schoolTypeList.clear();
          for (var element in baseResponse) {
            schoolTypeList.add(element);
          }}
      }
    } catch (error) {

      logs('Error: $error');
    }
  }
  Future<void> fetchCurriculum() async {
    final Dio dio = Dio();
    try {
      Response response = await dio.get('http://167.99.93.83/api/v1/school/curriculum',
        options: await _headers(),);

      logs('Status code--> ${response.statusCode}');

      if (response.statusCode == 200) {

        if(response.data['status']['type']=='success'){
          // ignore: always_specify_types
          final List baseResponse = response.data['data']['items'] ;
          curriculumTypeList.clear();
          for (var element in baseResponse) {
            curriculumTypeList.add(element);
          }}
      }
    } catch (error) {

      logs('Error: $error');
    }
  }
  Future<void> fetchTypeOfClass() async {
    final Dio dio = Dio();
    try {
      Response response = await dio.get('http://167.99.93.83/api/v1/school/classtype',
        options: await _headers(),);

      logs('Status code--> ${response.statusCode}');

      if (response.statusCode == 200) {

        if(response.data['status']['type']=='success'){
          // ignore: always_specify_types
          final List baseResponse = response.data['data']['items'] ;
          classTypeList.clear();
          for (var element in baseResponse) {
            classTypeList.add(element);
          }}
      }
    } catch (error) {

      logs('Error: $error');
    }
  }
  Future<void> teachingInformationUpdate() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        "grades": selectedGrade.toList(),
        "subjects": selectedSubject.toList(),
        "schoolTypes": selectedSchoolType.toList(),
        "classTypes": selectedClassType.toList(),
        "curriculum": selectedCurriculum.toList()
      };
      logs('body--> $body');
      final Response response = await dio.put(
        'http://167.99.93.83/api/v1/users/profile/teaching',
        data: body,
        options: await _headers(),
      );
      logs('status Code --> ${response.statusCode}');
      if (response.statusCode == 200) {
        logs('Login response  --> ${response.data.toString()}');
        HomeController _home=Get.find();
        _home.fetchData();
        EasyLoading.dismiss();
        AppRouter.pushNamed(Routes.experienceInfo);
      } else {
        EasyLoading.dismiss();
        logs('error not response');
      }
    } on DioException catch (error) {
      EasyLoading.dismiss();
    }
  }
}
