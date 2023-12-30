import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../core/base_response.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/utils/validators.dart';
import '../model/response_model/reset_pass_email_response_model.dart';
import '../repository/forgot_password_repository.dart';

class TutorialController extends GetxController{

  final ForgotPasswordRepository _forgotPasswordRepository=ForgotPasswordRepository();



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
    final BaseResponse response = await _forgotPasswordRepository.forgotPassword(
       email:  forgotEmailController.text,
    );
      if (response.status?.type == 'success') {
        hideLoading();
        AppRouter.pushNamed(Routes.restPassword);
      } else {
        errors.value=response.status?.message??'Error occured';
      }
      hideLoading();

  }
}
