import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';

class UserInfoController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    KeyValueStorageBase.init();
    final KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    currentProfile.value = keyValueStorageBase.getCommon(String,KeyValueStorageService.profile) ?? '';

  }


  Map data = <String, dynamic>{};


  RxString currentProfile = ''.obs;


  TextEditingController firstNameController = TextEditingController();


  TextEditingController lastNameController = TextEditingController();


  RxString firstNameErrorText = ''.obs;


  RxString lastNameErrorText = ''.obs;


  RxInt firstNameValid = 2.obs;


  RxInt lastNameValid = 2.obs;

  final Map<String, dynamic> arguments = <String, dynamic>{};


  RxBool isActiveSwitch = false.obs;


  void onTapSwitch() {
    isActiveSwitch.value = !isActiveSwitch.value;
    arguments['hideUserName'] = isActiveSwitch;
    logs('isActiveSwitch-->$isActiveSwitch');
  }


  void validateFirstName(String value) {
    if (value!.isEmpty) {
      firstNameValid.value = 0;
      firstNameErrorText.value = 'pleaseEnterFirstName'.tr;
    } else if (Regexes.validateRegEx(
        firstNameController.text, Regexes.nameRegex)) {
      firstNameValid.value = 0;

      firstNameErrorText.value = 'enterValidName'.tr;
    } else {
      firstNameValid.value = 1;
      firstNameErrorText.value = '';
      logs('error--> $firstNameErrorText');
    }
  }


  void validateLastName(String value) {
    if (value!.isEmpty) {
      lastNameValid.value = 0;
      lastNameErrorText.value = 'Please enter Last Name';
    } else if (Regexes.validateRegEx(
        lastNameController.text, Regexes.nameRegex)) {
      lastNameValid.value = 0;

      lastNameErrorText.value = 'enterValidLastname';
    } else {
      lastNameValid.value = 1;
      lastNameErrorText.value = '';
      logs('error--> $lastNameErrorText');
    }
  }


  void onTapSubmitUserInfo() {
    if (firstNameValid == 1 && lastNameValid == 1) {
      arguments['userId'] = data['userId'];
      arguments['firstName'] = firstNameController.text;
      arguments['lastName'] = lastNameController.text;

      AppRouter.pushNamed(Routes.passwordView, args: arguments);
    }
  }


  bool isDisableUserInfoSubmit() {
    if (firstNameValid == 1 && lastNameValid == 1) {
      return false;
    } else {
      return true;
    }
  }
}
