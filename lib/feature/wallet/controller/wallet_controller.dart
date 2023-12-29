import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController{



  RxBool isActive = false.obs;


  TextEditingController withdrawController = TextEditingController();



  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  RxString amountError = ''.obs;


  RxInt bankBalance = 100.obs;




  bool onTapSwitch() {
    isActive.value = !isActive.value;
    return isActive.value;
  }


  String? withdrawAmountValidation(String value) {
    final int? amount = int.tryParse(value);
    if (value!.isEmpty) {
      return 'Please enter an amount';
    } else if (amount == null || amount <= bankBalance.value) {
      amountError.value = 'valid';
      return 'Enter an amount within your balance limit';
    } else {
      amountError.value = 'error';
    }
  }

}
