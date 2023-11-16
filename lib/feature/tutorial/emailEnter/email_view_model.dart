import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../../../product/utils/validators.dart';
import 'model/email_enter_model.dart';

part 'email_view_model.g.dart';

class EmailViewModel = _EmailViewModelBase with _$EmailViewModel;

abstract class _EmailViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    KeyValueStorageBase.init();
  }

  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();

  @observable
  Map<String, dynamic> arguments = {
    'id': '',
    'otp_id': '',
  };
  @action
  Future<void> registerMail() async {
    EasyLoading.show(status: 'loading...',  maskType: EasyLoadingMaskType.black);
    Dio dio = Dio();
    try {
      Map body = {
        'email': emailController.text,
        'role': keyValueStorageBase.getCommon(KeyValueStorageService.profile),
      };
      logs(body.toString());
      Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/register/email',
        data: body,
      );

      if (response.statusCode == 200) {
        final EmailEnterModel data = EmailEnterModel.fromJson(response.data);
        if (data.status.type == 'success') {
          logs('registered ${data.status.type}');
          arguments['id'] = data.data.item.userId;
          sendOTP(data.data.item.userId.toString());
        }
      } else {
         EasyLoading.dismiss();
        logs('error not response');
      }
    } catch (error) {
      logs('error');
    }
  }

  @action
  Future<void> sendOTP(String id) async {
    // viewModelContext.loaderOverlay.show();
    Dio dio = Dio();
    try {
      Map body = {
        'userId': id,
      };
      logs('body--> $body');
      final response = await dio.post(
        'http://167.99.93.83/api/v1/users/email/send-otp',
        data: body,
      );
      logs('status Code --> ${response.statusCode}');
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        logs('status Code --> ${response.data['status']['type']}');
        logs('status Code --> ${response.data['data']['item']['otp_id']}');
        arguments['otp_id'] = response.data['data']['item']['otp_id'];
        AppRouter.pushNamed(Routes.emailOtpView, args: arguments);

      } else {
        EasyLoading.dismiss();
        logs('error not response');
      }
    } catch (error) {
      logs('error');
    }
  }



  //========email========//
  @observable
  TextEditingController emailController =
      TextEditingController(text: 'abc@mailinator.com');

  @observable
  String emailErrorText = '';

  @observable
  int emailValid = 2;

  @action
  void validateEmail(String value) {
    if (value!.isEmpty) {
      emailValid = 0;
      emailErrorText = 'pleaseEnter'.tr();
    } else if (Regexes.validateRegEx(
        emailController.text, Regexes.emailRegex)) {
      emailValid = 0;
      emailErrorText = 'enterValidEmail'.tr();
    } else {
      emailValid = 1;
      emailErrorText = '';
      logs('error--> $emailValid');
    }
  }

  @action
  void onTapEmailSubmit() {
    if (emailValid == 1) {
      registerMail();
    }
  }
}
