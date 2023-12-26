import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/utils/validators.dart';
import '../model/response_model/reset_pass_email_response_model.dart';

part 'tutorial_view_model.g.dart';

class TutorialViewModel = _TutorialViewModelBase with _$TutorialViewModel;

abstract class _TutorialViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  @observable
  String errors = '';

  @observable
  int selectedIndex = -1;

  @observable
  TextEditingController firstNameController = TextEditingController();

  @observable
  ResetPassEmailResponseModel resetPassEmailResponseModel =
      ResetPassEmailResponseModel();

  @observable
  TextEditingController forgotEmailController = TextEditingController();

  @observable
  TextEditingController emailController = TextEditingController();

  @observable
  TextEditingController lastNameController = TextEditingController();

  @observable
  List profileItems = <String>['Teacher', 'Parent/Student'];

  @observable
  bool isButtonDisabled = true;

  @observable
  int emailValid = 2;

  @observable
  String emailErrorText = '';

  @action
  void validateEmail(String value) {
    if (value.isEmpty) {
      emailValid = 0;
      emailErrorText = 'pleaseEnter'.tr;
    } else if (Regexes.validateRegEx(
        forgotEmailController.text, Regexes.emailRegex)) {
      emailValid = 0;
      emailErrorText = 'enterValidEmail'.tr;
    } else {
      emailValid = 1;
      emailErrorText = '';
    }

    if (emailValid != 1) {
      isButtonDisabled = true;
    } else {
      isButtonDisabled = false;
    }
  }

  @action
  Future<void> forgotPassword() async {
    showLoading();
    final Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        'email': forgotEmailController.text,
      };
      logs('body--> $body');
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/request-reset',
        data: body,
      );
      if (response.data['status']['type'] == 'success') {
        hideLoading();
        resetPassEmailResponseModel =
            ResetPassEmailResponseModel.fromJson(response.data);
        AppRouter.pushNamed(Routes.restPassword);
      } else {
        errors=response.data['status']['message'];
        hideLoading();
      }
    } on DioException catch (error) {
      hideLoading();
      resetPassEmailResponseModel =
          ResetPassEmailResponseModel.fromJson(error.response!.data);
      errors = resetPassEmailResponseModel.status!.message!;

      logs('data --> ${resetPassEmailResponseModel.status!.message}');
    }
  }
}
