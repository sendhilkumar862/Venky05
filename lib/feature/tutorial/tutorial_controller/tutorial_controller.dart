import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/utils/validators.dart';
import '../model/response_model/reset_pass_email_response_model.dart';

class TutorialController extends GetxController{





  RxString errors = ''.obs;


  // RxInt selectedIndex = -1.obs;


  TextEditingController firstNameController = TextEditingController();


  Rx<ResetPassEmailResponseModel> resetPassEmailResponseModel =
  ResetPassEmailResponseModel().obs;


  TextEditingController forgotEmailController = TextEditingController();


  TextEditingController emailController = TextEditingController();


  TextEditingController lastNameController = TextEditingController();


  List profileItems = <String>['Teacher', 'Parent/Student'];


  RxBool isButtonDisabled = true.obs;


  RxInt emailValid = 2.obs;


  RxString emailErrorText = ''.obs;


  void validateEmail(String value) {
    if (value.isEmpty) {
      emailValid.value = 0;
      emailErrorText.value = 'pleaseEnter'.tr;
    } else if (Regexes.validateRegEx(
        forgotEmailController.text, Regexes.emailRegex)) {
      emailValid.value = 0;
      emailErrorText.value = 'enterValidEmail'.tr;
    } else {
      emailValid.value = 1;
      emailErrorText.value = '';
    }

    if (emailValid != 1) {
      isButtonDisabled.value = true;
    } else {
      isButtonDisabled.value = false;
    }
  }


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
        resetPassEmailResponseModel.value =
            ResetPassEmailResponseModel.fromJson(response.data);
        AppRouter.pushNamed(Routes.restPassword);
      } else {
        errors=response.data['status']['message'];
        hideLoading();
      }
    } on DioException catch (error) {
      hideLoading();
      resetPassEmailResponseModel.value =
          ResetPassEmailResponseModel.fromJson(error.response!.data);
      errors.value = resetPassEmailResponseModel.value.status!.message!;

      logs('data --> ${resetPassEmailResponseModel.value.status!.message}');
    }
  }
}
