import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../product/cache/locale_manager.dart';

part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  @observable
  int selectedIndex = -1;

  @observable
  List profileItems = <String>['Teacher', 'Parent/Student'];

  @action
  void selectProfile(int index) {
    selectedIndex = index;
    LocaleManager.instance.setIntValue(LocaleManager.profile, index);
  }

  @action
  bool isSelected() {
    if (selectedIndex == -1) {
      return false;
    } else {
      return true;
    }
  }
}
