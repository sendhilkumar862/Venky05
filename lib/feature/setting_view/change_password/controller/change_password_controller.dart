import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/base_response.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/utils/validators.dart';
import '../../../tutorial/password/model/term_and_condition_model.dart';
import '../repository/change_password_repository.dart';

class ChangePasswordController extends GetxController {
  Map arguments = <String, dynamic>{};
  // RxBool isActive = false.obs;
  TermAndConditionModel termAndConditionModel =  TermAndConditionModel();
  List<bool> isPassWordCriteria = List.filled(6, false);
  List<String> passWordCriteria = <String>[
    'minCharacters'.tr,
    'containNumbers'.tr,
    'containSpecialChars'.tr,
    'containUppercase'.tr,
    'containLowercase'.tr,
    'matchPasswords'.tr,
  ];
  RxBool isButtonActive = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isWrongOldPassword = false.obs;
  RxString error = ''.obs;
  RxInt noOfAttempts = 3.obs;
  RxString loginStatus = ''.obs;
  RxBool isRetypePasswordVisible = false.obs;
  RxBool isOldPasswordVisible = false.obs;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypedPasswordController = TextEditingController();

  final ChangePasswordRepository _changePasswordRepository =
      ChangePasswordRepository();

  @override
  void onInit() {
    KeyValueStorageBase.init();
    fetchData();
    isWrongOldPassword.value = false;
    oldPasswordController.clear();
    passwordController.clear();
    retypedPasswordController.clear();
    // TODO: implement onInit
    super.onInit();
  }

  void backButtonTapped() {
    isWrongOldPassword.value = false;
    oldPasswordController.clear();
    passwordController.clear();
    retypedPasswordController.clear();
    isPassWordCriteria = List.filled(6, false);
    // isActive.value = false;
  }

  Future<bool> requestChangePassword() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse changePasswordResponse =
        await _changePasswordRepository.passwordChange(
            oldPassword: oldPasswordController.text,
            newPassword: passwordController.text,
            retypedPassword: retypedPasswordController.text);
    if (changePasswordResponse.status?.type == 'success') {
      isWrongOldPassword.value = false;
      oldPasswordController.clear();
      passwordController.clear();
      retypedPasswordController.clear();
      isPassWordCriteria = List.filled(6, false);
      // isActive.value = false;
      EasyLoading.dismiss();
      return true;
    } else {
      isWrongOldPassword.value = true;
      noOfAttempts.value--;
      loginStatus.value = changePasswordResponse.status?.type ?? '';
      error.value = changePasswordResponse.status?.message ?? '';
      logs('Error Message--> ${error.value}');
      EasyLoading.dismiss();
      return false;
    }
  }

  Future<void> fetchData() async {}

  void onTapTermAndCondition() {
    // isActive.value = !isActive.value;
    isPassWordCriteria[5] =
        retypedPasswordController.text == passwordController.text &&
            passwordController.text.isNotEmpty;

    // isButtonActive.value = isActive.value && isPassWordCriteria.every((bool element) => element);
    isButtonActive.value = isPassWordCriteria.every((bool element) => element);
    // logs('isTermActive--> $isActive');
    logs('isPassWordCriteria--> $isPassWordCriteria');
    logs('isButtonActive--> $isButtonActive');
  }

  void validatePassword(String value, Function setState) {
    isPassWordCriteria[0] = value.length >= 8;
    isPassWordCriteria[1] = Regexes.validate(value, Regexes.digitRegExp);
    isPassWordCriteria[2] = Regexes.validate(value, Regexes.specialCharRegExp);
    isPassWordCriteria[3] = Regexes.validate(value, Regexes.uppercaseRegExp);
    isPassWordCriteria[4] = Regexes.validate(value, Regexes.lowercaseRegExp);
    isPassWordCriteria[5] =
        value == retypedPasswordController.text && value.isNotEmpty;
    // isButtonActive.value =
    // isActive.value && isPassWordCriteria.every((bool element) => element);
    isButtonActive.value = isPassWordCriteria.every((bool element) => element);
    setState(() {});
  }

  void validateRetypePassword(String value, Function setState) {
    isPassWordCriteria[5] =
        value == passwordController.text && value.isNotEmpty;
    //   isButtonActive.value =
    // isActive.value && isPassWordCriteria.every((bool element) => element);
    isButtonActive.value = isPassWordCriteria.every((bool element) => element);
    logs('isPassWordCriteria--> $isPassWordCriteria');
    setState(() {});
  }

  void setCriteria(int index, bool value) {
    isPassWordCriteria[index] = value;
  }
}
