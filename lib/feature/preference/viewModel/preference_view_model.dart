import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hessah/config/routes/app_router.dart';
import 'package:hessah/product/network/local/key_value_storage_base.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../../../product/utils/validators.dart';
import '../../tutorial/model/response_model/response_model.dart';
import '../model/preference_model.dart';
import '../model/preference_request.dart';

part 'preference_view_model.g.dart';

class PreferenceViewModel = _PreferenceViewModelBase with _$PreferenceViewModel;

abstract class _PreferenceViewModelBase extends BaseViewModel with Store {
  @observable
  List<String> selectedGrade = <String>[];

  @observable
  List<String> selectedSchool = <String>[];

  @observable
  List<String> selectedSchoolIndices = <String>[];

  @observable
  List<String> selectedCurriculumIndices = <String>[];

  @observable
  List<String> selectedSubjectIndices = <String>[];

  @observable
  List<Curriculum>? grade;

  @observable
  List<Curriculum>? schoolType;

  @observable
  List<Curriculum>? curriculum;

  @observable
  List<Curriculum>? subject;

  @observable
  PreferenceModel preferenceModel = PreferenceModel();

  @observable
  ResponseSuccessModel responseSuccessModel = ResponseSuccessModel();

  @observable
  String errors = '';

  @observable
  String setPreferenceErrors = '';

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
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

  @action
  Future<void> getUserPreference() async {
    showLoading();
    final Dio dio = Dio();
    try {
      final Response response = await dio.get(
        'http://167.99.93.83/api/v1/users/preference',
        options: await _headers(),
      );
      if (response.statusCode == 200) {
        hideLoading();
        preferenceModel = PreferenceModel.fromJson(response.data);
        runInAction(() {
          grade = preferenceModel.data?.item?.grade ?? [];
          schoolType = preferenceModel.data?.item?.schoolType ?? [];
          curriculum = preferenceModel.data?.item?.curriculum ?? [];
          subject = preferenceModel.data?.item?.subject ?? [];
          setPreferenceData();
        });
      } else {
        hideLoading();
      }
    } on DioException catch (error) {
      hideLoading();
      preferenceModel = PreferenceModel.fromJson(error.response!.data);
      errors = preferenceModel.status!.message!;
      AppUtils.showFlushBar(
        icon: Icons.check_circle_outline_rounded,
        iconColor: Colors.green,
        context: AppRouter.navigatorKey.currentContext!,
        message: errors ?? 'Error occured',
      );
      logs('data --> ${preferenceModel.status!.message}');
    }
  }

  @action
  Future<void> setUserPreference() async {
    showLoading();
    final Dio dio = Dio();
    try {
      final Response response =
          await dio.post('http://167.99.93.83/api/v1/users/preference',
              options: await _headers(),
              data: preferenceRequestToJson(PreferenceRequest(
                grade: selectedGrade,
                schoolType: selectedSchoolIndices,
                curriculum: selectedCurriculumIndices,
                subject: selectedSubjectIndices,
              )));
      if (response.statusCode == 200) {
        responseSuccessModel = ResponseSuccessModel.fromJson(response.data);
        KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
        keyValueStorageBase.setCommon(
            KeyValueStorageService.setPreference, true);
        hideLoading();
      } else {
        hideLoading();
      }
    } on DioException catch (error) {
      hideLoading();
      responseSuccessModel =
          ResponseSuccessModel.fromJson(error.response!.data);
      setPreferenceErrors = responseSuccessModel.status!.message!;

      logs('data --> ${responseSuccessModel.status!.message}');
    }
  }

  void setPreferenceData() {
    runInAction(() {
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
    });
  }
}
