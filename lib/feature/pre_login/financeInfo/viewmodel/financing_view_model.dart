import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';


part 'financing_view_model.g.dart';

class FinancingViewModel = _FinancingViewModelBase with _$FinancingViewModel;

abstract class _FinancingViewModelBase extends BaseViewModel with Store {

  @observable
  TextEditingController ibanController = TextEditingController();

  @observable
  TextEditingController nickNameController = TextEditingController();

  @observable
  String ibanError = '';

  @observable
  bool isSuccess = false;

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  var maskFormatter =  MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  @override
  Future<void> init() async {
   
  }

  @action
  void validateIBAN(String value) {
    if (value.isEmpty) {
      ibanError = 'ibanError'.tr();
    } else if (value.length != 30){
      ibanError = 'ibanLengthError'.tr();
    } else if (!value.startsWith('KU')) {
      ibanError = 'iabnLocalError'.tr();
    } else {
      ibanError = '';
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

  @action
  Future<bool> updateData() async {
     EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        'iban': ibanController.text,
        'isDefault':true,
        'nickName': nickNameController.text
      };
      logs('body--> $body');
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/profile/iban/',
        data: body,
        options: await _headers(),
      );
      logs('status Code --> ${response.statusCode}');
      if (response.statusCode == 200) {
        logs('Login response  --> ${response.data.toString()}');
        EasyLoading.dismiss();
        return true;

      } else {
        EasyLoading.dismiss();
        logs('error not response');
        return false;
      }
    } on DioException {
      EasyLoading.dismiss();
      return false;
    }
  }

  Future<Options> _headers() async {
    final KeyValueStorageService keyValueStorageService =
    KeyValueStorageService();
    final String token = await keyValueStorageService.getAuthToken();
    print("get token ${token}");
    return Options(
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
    );
  }

}
