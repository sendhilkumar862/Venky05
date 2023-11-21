import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/constants/app/app_utils.dart';
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
  TextEditingController emailController =
      TextEditingController(text: 'abc@mailinator.com');

  @observable
  String emailErrorText = '';

  @observable
  String loginError = '';

  @observable
  LoginModel loginModel = LoginModel();

  @observable
  int emailValid = 2;

  @observable
  bool isButtonDisabled = true;

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
      FocusManager.instance.primaryFocus?.unfocus();
      logs('error--> $emailValid');
    }

    if (emailValid != 1) {
      isButtonDisabled = true;
    } else if (passwordController.text.isEmpty) {
      isButtonDisabled = true;
    } else if (loginModel.status!.type == null || loginModel.status!.type == 'error') {
      isButtonDisabled = true;
    } else {
      isButtonDisabled = false;
    }
  }

  @action
  void onTapLoginSubmit() {
    // its test mode condition will change
    if (isButtonDisabled) {
      AppRouter.pushNamed(
        Routes.HomeScreenRoute,
      );
    }
  }

  @action
  void onPasswordChanged(String value) {
    if (emailValid != 1) {
      isButtonDisabled = true;
    } else if (value.isEmpty) {
      isButtonDisabled = true;
    } else if (loginModel.status!.type != null &&
        loginModel.status!.type == 'error') {
      isButtonDisabled = true;
    } else {
      isButtonDisabled = false;
    }
  }

  @action
  Future<void> login() async {
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
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        loginModel = LoginModel.fromJson(response.data);
        logs('ress--> $loginModel');
      } else {
        EasyLoading.dismiss();
        logs('error not response');
      }
    } on DioException catch (error) {
      loginModel = LoginModel.fromJson(error.response!.data);
      loginError = loginModel.status!.message!;
      logs('data --> ${loginModel.status!.message}');
    }
  }
}
