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
import '../model/login_Model.dart';

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
  void onTapLoginSubmit() {
    if (emailValid == 1) {
      login();
    }
  }

  @action
  Future<void> login() async {
    Dio dio = Dio();
    try {
      Map body = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      logs('body--> $body');
      final response = await dio.post(
        'http://167.99.93.83/api/v1/users/login',
        data: body,
      );
      logs('status Code --> ${response.statusCode}');
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        LoginModel loginModel = LoginModel.fromJson(response.data);
        logs('ress--> ${loginModel}');

        AppRouter.pushNamed(
          Routes.HomeScreenRoute,
        );
      } else {
        EasyLoading.dismiss();
        logs('error not response');
      }
    } catch (error) {
      logs('error');
    }
  }
}
