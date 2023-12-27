import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;
import 'package:mobx/mobx.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../../../home/controller/home_controller.dart';
import '../../personalInfo/controller/personal_info_controllere.dart';

part 'experience_info_view_model.g.dart';

class ExperienceInfoViewModel = _ExperienceInfoViewModelBase
    with _$ExperienceInfoViewModel;

abstract class _ExperienceInfoViewModelBase extends BaseViewModel with Store {
  final PersonalInfoController _personalInfoController= Get.put(PersonalInfoController());
  @observable
  File? firstImage;
  File? secondImage;
  bool isSwitchEduction = false;
  bool isSwitchExperience = false;
  bool isSwitchCertificates = false;
  @observable
  TextEditingController educationController = TextEditingController();
  @observable
  TextEditingController experienceYearController = TextEditingController();
  @observable
  TextEditingController experienceBriefController = TextEditingController();


  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  void init() {
  }
  @action
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
  @action
  Future<void> experienceInformationUpdate() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        "education": educationController.text,
        "educationIsPublic": isSwitchEduction,
        "experience": int.parse(experienceYearController.text),
        "experienceDetails": experienceBriefController.text,
        "experienceIsPublic": isSwitchExperience,
        "certificateIds": _personalInfoController.civilIds,
        "certificateIsPublic": isSwitchCertificates
      };
      logs('body--> $body');
      final Response response = await dio.put(
        'http://167.99.93.83/api/v1/users/profile/experience',
        data: body,
        options: await _headers(),
      );
      logs('status Code --> ${response.statusCode}');
      if (response.statusCode == 200) {
        logs('Login response  --> ${response.data.toString()}');
        _personalInfoController.civilIds.clear();
        HomeController _home=Get.find();
        _home.fetchData();
        EasyLoading.dismiss();
        AppRouter.pushNamed(Routes.financingView);
      } else {
        EasyLoading.dismiss();
        logs('error not response');
      }
    } on DioException catch (error) {
      EasyLoading.dismiss();
    }
  }
}
