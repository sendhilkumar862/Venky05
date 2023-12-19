import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;
import 'package:mobx/mobx.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../product/base/model/base_model.dart';
import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../model/login_model.dart';

part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
  @observable
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @observable
  String emailErrorText = '';

  @observable
  String loginError = '';

  @observable
  String loginStatus = '';

  @observable
  int emailValid = 2;

  @observable
  bool isButtonDisabled = true;

  @observable
  bool isPasswordShow = true;

  @action
  void validateEmail(String value) {
    loginStatus = '';

    if (value.isEmpty) {
      emailValid = 0;
      emailErrorText = 'pleaseEnter'.tr;
    } else if (Regexes.validateRegEx(emailController.text, Regexes.emailRegex)) {
      emailValid = 0;
      emailErrorText = 'enterValidEmail'.tr;
    } else {
      emailValid = 1;
      emailErrorText = '';
      logs('error--> $emailValid');
    }

    if (emailValid != 1) {
      isButtonDisabled = true;
    } else if (passwordController.text.isEmpty) {
      isButtonDisabled = true;
    } else {
      isButtonDisabled = false;
    }
  }

  @action
  void onTapLoginSubmit() {
    login();
  }

  @action
  void onPasswordChanged(String value) {
    loginStatus = '';
    if (emailValid != 1) {
      isButtonDisabled = true;
    } else if (value.isEmpty) {
      isButtonDisabled = true;
    } else {
      isButtonDisabled = false;
    }
  }

  @action
  Future<void> login() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        'email': emailController.text,
        'password': passwordController.text,
      };
      logs('body--> $body');
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/login',
        data: body,
      );
      logs('status Code --> ${response.statusCode}');
      final BaseResponse<LoginModel> baseResponse =
            BaseResponse<LoginModel>.fromJson(response.data, LoginModel.fromJson);
      loginStatus = baseResponse.status.type;
      if (response.statusCode == 200) {
         EasyLoading.dismiss();
        final KeyValueStorageService keyValueStorageService = KeyValueStorageService();
        if (baseResponse.data.item?.token?.accessToken?.isNotEmpty ?? false) {
           keyValueStorageService.setAuthToken(baseResponse.data.item?.token?.accessToken ?? '');
           AppRouter.pushNamed(Routes.HomeScreenRoute);
        } else {
           loginError = baseResponse.status.message;
        }
      } else {
        EasyLoading.dismiss();
        loginError = baseResponse.status.message;
        logs('error not response');
      }
    } on DioException {
      EasyLoading.dismiss();
    }
  }
}
