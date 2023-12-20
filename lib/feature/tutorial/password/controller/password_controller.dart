

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hessah/product/network/local/key_value_storage_base.dart';

import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/utils/validators.dart';
import '../model/term_and_condition_model.dart';

class PasswordController extends GetxController{
  Map arguments = <String, dynamic>{};
  RxBool isActive = false.obs;
  TermAndConditionModel termAndConditionModel = const TermAndConditionModel();
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
  String errors = '';
  RxBool isRetypePasswordVisible = false.obs;
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();


  @override
  void onInit() {
    void init() {
      KeyValueStorageBase.init();
      fetchData();
    }
    // TODO: implement onInit
    super.onInit();
  }


  Future<bool> registerUser() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    return true;
  }



  Future<void> fetchData() async {}

  void onTapTermAndCondition() {
    isActive.value = !isActive.value;
    isPassWordCriteria[5] =
        retypePasswordController.text == passwordController.text && passwordController.text.isNotEmpty;

    isButtonActive.value = isActive.value && isPassWordCriteria.every((bool element) => element);
    logs('isTermActive--> $isActive');
    logs('isPassWordCriteria--> $isPassWordCriteria');
    logs('isButtonActive--> $isButtonActive');
  }

  void validatePassword(String value, Function setState) {
    isPassWordCriteria[0] = value.length >= 8;
    isPassWordCriteria[1] = Regexes.validate(value, Regexes.digitRegExp);
    isPassWordCriteria[2] = Regexes.validate(value, Regexes.specialCharRegExp);
    isPassWordCriteria[3] = Regexes.validate(value, Regexes.uppercaseRegExp);
    isPassWordCriteria[4] = Regexes.validate(value, Regexes.lowercaseRegExp);
    isPassWordCriteria[5] = value == retypePasswordController.text && value.isNotEmpty;
    isButtonActive.value = isActive.value && isPassWordCriteria.every((bool element) => element);
    setState(() {});
  }

  void validateRetypePassword(String value, Function setState) {
    isPassWordCriteria[5] = value == passwordController.text && value.isNotEmpty;
    isButtonActive.value = isActive.value && isPassWordCriteria.every((bool element) => element);
    logs('isPassWordCriteria--> $isPassWordCriteria');
    setState(() {});
  }

  void setCriteria(int index, bool value) {
    isPassWordCriteria[index] = value;
  }
}