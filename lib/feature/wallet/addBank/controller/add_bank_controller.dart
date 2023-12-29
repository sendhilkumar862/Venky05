import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../product/utils/validators.dart';

class AddBankController extends GetxController{




  TextEditingController accountController = TextEditingController();


  TextEditingController nameController = TextEditingController();



  RxString accountError = ''.obs;


  RxString nameError = ''.obs;


  RxInt accountValid = 2.obs;


  RxInt nameValid = 2.obs;


  RxBool isActive = false.obs;


  void onTapSwitch() {
    isActive.value  = !isActive.value;
  }


  void validateAccount(String value) {
    if (value.isEmpty) {
      accountValid.value = 0;
      accountError.value = 'Please enter account number';
    } else if (value.length < 30) {
      accountValid.value = 0;
      accountError.value = 'Minimum IBAN number should be 30 digits';
    } else {
      accountValid.value = 1;
      accountError.value = '';
    }
  }


  void validateName(String value) {
    if (value.isEmpty) {
      nameValid.value = 0;
      nameError.value = 'Please enter nickname';
    } else {
      nameValid.value = 1;
      nameError.value = '';
      logs('error--> $accountValid');
    }
  }
}
