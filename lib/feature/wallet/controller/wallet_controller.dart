import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/base_response.dart';
import '../repository/settle_payments_repository.dart';
import '../repository/withdraw_amount_repository.dart';

class WalletController extends GetxController{
 String requestType='';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestType=Get.arguments;
  }
  RxBool isActive = false.obs;


  TextEditingController withdrawController = TextEditingController();
  final WithdrawAmountRepository _withdrawAmountRepository= WithdrawAmountRepository();

  final SettlePaymentsRepository _settlePaymentsRepository= SettlePaymentsRepository();

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

  Future<void> withdrawAddAmount(int amount,String requestType) async {
    final BaseResponse getWalletBalanceDataResponse = await _withdrawAmountRepository.withdrawAmount(amount, requestType);
    if (getWalletBalanceDataResponse.status?.type == 'success') {

    }
  }


  Future<void> settlePaymentAmount(int amount) async {
    final BaseResponse getWalletBalanceDataResponse = await _settlePaymentsRepository.settlePayment(amount);
    if (getWalletBalanceDataResponse.status?.type == 'success') {

    }
  }

}
