import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/base/model/base_model.dart';
import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../../onboarding/view/onboading_view.dart';
import '../model/about_model.dart';

part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    fetchData();
    isSelected();
    KeyValueStorageBase.init();
  }

  @observable
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();

  @observable
  int selectedIndex = -1;

  @observable
  List<String> profileItems = <String>['teacher'.tr(), 'parent'.tr()];

  @observable
  List<AboutModel> data =  [];

  @action
  void selectProfile(int index) {
    selectedIndex = index;
    // if (index == 0) {
    //   keyValueStorageBase.setCommon(KeyValueStorageService.profile, 'Tutor');
    // } else {
    //   keyValueStorageBase.setCommon(KeyValueStorageService.profile, 'Student');
    // }

    isSelected();
  }

  @action
  bool isSelected() {
    if (selectedIndex == -1) {
      return false;
    } else {
      return true;
    }
  }

  @action
  void onTapSubmit() {
    if (isSelected()) {
      keyValueStorageBase.setCommon(KeyValueStorageService.profile, selectedIndex == 0 ? 'Tutor' : 'Student');
      AppRouter.push(const OnboardingView());
    }
  }

  @action
  Future<void> fetchData() async {
    showLoading();
    final Dio dio = Dio();
    try {
      final Response response = await dio.get('http://167.99.93.83/api/v1/content/role/common/type/about_us');
      logs('status code--> ${response.statusCode}');
      if (response.statusCode == 200) {
        hideLoading();
        final BaseResponse<AboutModel> baseResponse = BaseResponse<AboutModel>.fromJson(response.data as Map<String, dynamic>, AboutModel.fromJson);
        data = baseResponse.data.items?? <AboutModel>[];
        logs("${data[0].title}");
      } else {
        logs('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      logs('Error: $error');
    }
  }
}
