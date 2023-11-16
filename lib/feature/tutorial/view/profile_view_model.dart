import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../product/cache/locale_manager.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../../../product/utils/validators.dart';
import '../onboarding/onboading_view.dart';

part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    isSelected();
    KeyValueStorageBase.init();

  }

  @observable
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();

  @observable
  int selectedIndex = -1;

  @observable
  List profileItems = <String>['teacher'.tr(), 'parent'.tr()];

  @action
  void selectProfile(int index) {
    selectedIndex = index;
    if (index == 0) {
      keyValueStorageBase.setCommon(KeyValueStorageService.profile, 'Teacher');
    } else {
      keyValueStorageBase.setCommon(KeyValueStorageService.profile, 'Student');
    }

    isSelected();
    logs(isSelected().toString());
    logs(
        'storage get -- > ${keyValueStorageBase.getCommon(KeyValueStorageService.profile)}');
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
      AppRouter.push(const OnboardingView());
    }
  }
}
