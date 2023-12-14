import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/common_function.dart';

part 'class_detail_view_model.g.dart';

class ClassDetailViewModel = _ClassDetailViewModelBase
    with _$ClassDetailViewModel;

abstract class _ClassDetailViewModelBase extends BaseViewModel with Store {
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  final KeyValueStorageService keyValueStorageService =
      KeyValueStorageService();

  @observable
  String selectedProfile = '';

  @observable
  String selectedTimes = formatTime(DateTime.now());

  @observable
  String selectedDate = formatTime(DateTime.now());

  @observable
  bool isActive = false;

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    selectedProfile =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ??
            '';
  }

  @action
  bool onTapSwitch() {
    isActive = !isActive;
    return isActive;
  }
}
