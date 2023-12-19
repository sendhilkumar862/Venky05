
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';

part 'user_info_view_model.g.dart';

class UserInfoViewModel = _UserInfoViewModelBase with _$UserInfoViewModel;

abstract class _UserInfoViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    KeyValueStorageBase.init();
    final KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
     currentProfile = keyValueStorageBase.getCommon(String,KeyValueStorageService.profile) ?? '';

  }

  @observable
  Map data = <String, dynamic>{};

  @observable
  String currentProfile = '';

  @observable
  TextEditingController firstNameController = TextEditingController();

  @observable
  TextEditingController lastNameController = TextEditingController();

  @observable
  String firstNameErrorText = '';

  @observable
  String lastNameErrorText = '';

  @observable
  int firstNameValid = 2;

  @observable
  int lastNameValid = 2;

  final Map<String, dynamic> arguments = <String, dynamic>{};

  @observable
  bool isActiveSwitch = false;

  @action
  void onTapSwitch() {
    isActiveSwitch = !isActiveSwitch;
    arguments['hideUserName'] = isActiveSwitch;
    logs('isActiveSwitch-->$isActiveSwitch');
  }

  @action
  void validateFirstName(String value) {
    if (value!.isEmpty) {
      firstNameValid = 0;
      firstNameErrorText = 'pleaseEnterFirstName'.tr;
    } else if (Regexes.validateRegEx(
        firstNameController.text, Regexes.nameRegex)) {
      firstNameValid = 0;

      firstNameErrorText = 'enterValidName'.tr;
    } else {
      firstNameValid = 1;
      firstNameErrorText = '';
      logs('error--> $firstNameErrorText');
    }
  }

  @action
  void validateLastName(String value) {
    if (value!.isEmpty) {
      lastNameValid = 0;
      lastNameErrorText = 'Please enter Last Name';
    } else if (Regexes.validateRegEx(
        lastNameController.text, Regexes.nameRegex)) {
      lastNameValid = 0;

      lastNameErrorText = 'enterValidLastname';
    } else {
      lastNameValid = 1;
      lastNameErrorText = '';
      logs('error--> $lastNameErrorText');
    }
  }

  @action
  void onTapSubmitUserInfo() {
    if (firstNameValid == 1 && lastNameValid == 1) {
      arguments['userId'] = data['userId'];
      arguments['firstName'] = firstNameController.text;
      arguments['lastName'] = lastNameController.text;

      AppRouter.pushNamed(Routes.passwordView, args: arguments);
    }
  }

  @action
  bool isDisableUserInfoSubmit() {
    if (firstNameValid == 1 && lastNameValid == 1) {
      return false;
    } else {
      return true;
    }
  }
}
