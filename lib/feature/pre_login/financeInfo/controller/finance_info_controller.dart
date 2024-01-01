import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;

import '../../../../core/base_response.dart';
import '../../../home/controller/home_controller.dart';
import '../model/finance_info_update_model_request.dart';
import '../repository/finance_update_repository.dart';

class FinanceInfoController extends GetxController {
  TextEditingController ibanController = TextEditingController();

  TextEditingController nickNameController = TextEditingController();
  final FinanceInfoUpdateRepository _financeInfoUpdateRepository =
      FinanceInfoUpdateRepository();

  RxString ibanError = ''.obs;

  RxBool isSuccess = false.obs;

  void validateIBAN(String value) {
    final String iban = validateKuwaitIBAN(value);
    if (value.isEmpty) {
      ibanError.value = 'ibanError'.tr;
    } else if (value.length != 30) {
      ibanError.value = 'ibanLengthError'.tr;
    } else if (!value.startsWith('KW')) {
      ibanError.value = 'ibanLocalError'.tr;
    } else if (iban.isNotEmpty) {
      ibanError.value = 'ibanInvalid'.tr;
    } else {
      ibanError.value = '';
    }
  }

  String validateKuwaitIBAN(String iban) {
    // Kuwait IBAN format: KWkk bbbb cccc cccc cccc cccc cccc cc
    final RegExp regex = RegExp(r'^KW\d{2}[A-Z]{4}\d{22}$');
    if (!regex.hasMatch(iban)) {
      return ''; // Invalid format
    }

    // Additional validation steps can be added here if needed

    return iban;
  }

  Future<bool> financeInformationUpdate() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse personalUpdate = await _financeInfoUpdateRepository
        .financeInfoUpdateRepository(FinanceInfoUpdateRequest(
            iban: ibanController.text,
            isDefault: true,
            nickName: nickNameController.text));
    if (personalUpdate.status?.type == 'success') {
      final HomeController home = Get.find();
      home.fetchData();
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.dismiss();
      return false;
    }
  }
}

class IBANTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }
    var dateText = _addSeparator(newValue.text, ' ');
    return newValue.copyWith(
        text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeparator(String value, String separator) {
    value = value.replaceAll(' ', '');
    String newString = '';
    bool separatorCheck(int localValue) {
      for (int i = 0; i < value.length; i++) {
        if (localValue == (4 * (i + 1) - 1)) {
          return true;
        }
      }
      return false;
    }

    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (separatorCheck(i)) {
        newString += separator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
