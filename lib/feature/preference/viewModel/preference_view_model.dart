import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/utils/validators.dart';
import '../model/preference_model.dart';

part 'preference_view_model.g.dart';

class PreferenceViewModel = _PreferenceViewModelBase with _$PreferenceViewModel;

abstract class _PreferenceViewModelBase extends BaseViewModel with Store {
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
  String errors = '';

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    getUserPreference();
  }

  Options _headers() {
    return Options(
      headers: {
        'Content-Type': ' application/json',
        'X-Auth-Token':
            'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI5Iiwicm9sZSI6IlN0dWRlbnQiLCJqdGkiOiJiOWJjYzc0Ni05ZDlkLTQ3MDYtYTNlYS05NjlhNTRhYmU3ODMiLCJpYXQiOjE3MDA2NDQ3NjcsImV4cCI6MTcwMDczMTE2NywiYXVkIjoiOSIsImlzcyI6Imhlc3NhIn0.TSAXXQqhDq3Mme1u8I4GPAc5LK3_mHNlxeks-xN4N1_XiukDsPbqxHpxGGEL1805fexYevkIWq1On3VN20yBj4GW2XA6CKOysfaXRFg_WKW7AnYMieQIREEqgH3VCcvuAxkhRINLhM_hRl_0S3PRHBZVfhQ2gzP8O3j7ud513LNPd14R0ojD8sHBcVE5NXr-EUYnX4F67Ljfcaavcimv4F3x5f88mM912ufpswrbF400s3tPJwD71mewKSAs2Jtb7I5E3aiIQPNGpKE3RUbltD9BFOGROtNYJCn_ugaYPkSR6nIiVdBGoKRhPxkbSzkVnoz6KfyNcaPaNlvK2z_4Ow',
      },
    );
  }

  @action
  Future<void> getUserPreference() async {
    showLoading();
    final Dio dio = Dio();
    try {
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/preference',
        options: _headers(),
      );
      if (response.statusCode == 200) {
        hideLoading();
        preferenceModel = PreferenceModel.fromJson(response.data);
        runInAction(() {
          grade = preferenceModel.data?.item?.grade;
          schoolType = preferenceModel.data?.item?.schoolType;
          curriculum = preferenceModel.data?.item?.curriculum;
          subject = preferenceModel.data?.item?.subject;
        });
      } else {
        hideLoading();
      }
    } on DioException catch (error) {
      hideLoading();
      preferenceModel = PreferenceModel.fromJson(error.response!.data);
      errors = preferenceModel.status!.message!;

      logs('data --> ${preferenceModel.status!.message}');
    }
  }
}
