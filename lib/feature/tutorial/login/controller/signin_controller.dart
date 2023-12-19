
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/base_response.dart';
import '../model/login_model.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../../../../repository/auth_repositoriy.dart';


class SignInController extends GetxController {
  RxString error=''.obs;
  RxString emailErrorText = ''.obs;
  RxString loginError = ''.obs;
  RxString loginStatus = ''.obs;
  RxInt emailValid = 2.obs;
  RxBool isButtonDisabled = true.obs;
  RxBool isPasswordShow = true.obs;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final AuthRepositoryRepository _authRepositoryRepository = AuthRepositoryRepository();

  void validateEmail(String value) {
    loginStatus.value = '';

    if (value.isEmpty) {
      emailValid.value = 0;
      emailErrorText.value = 'pleaseEnter'.tr;
    } else if (Regexes.validateRegEx(emailController.text, Regexes.emailRegex)) {
      emailValid.value = 0;
      emailErrorText.value = 'enterValidEmail'.tr;
    } else {
      emailValid.value = 1;
      emailErrorText.value = '';
      logs('error--> $emailValid');
    }

    if (emailValid != 1) {
      isButtonDisabled.value = true;
    } else if (passwordController.text.isEmpty) {
      isButtonDisabled.value = true;
    } else {
      isButtonDisabled.value = false;
    }
  }

  void onPasswordChanged(String value) {
    loginStatus.value = '' ;
    if (emailValid != 1) {
      isButtonDisabled.value = true;
    } else if (value.isEmpty) {
      isButtonDisabled.value = true;
    } else {
      isButtonDisabled.value = false;
    }
  }
  void onTapLoginSubmit() {
    login();
  }

  Future<void> login() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse signInResponse = await _authRepositoryRepository.sign(
        email: emailController.text, password: passwordController.text);
    if (signInResponse.status?.type == 'success') {
      final LoginModel responseData = LoginModel.fromJson(
          signInResponse.data!.item! as Map<String, dynamic>);
      final KeyValueStorageService keyValueStorageService = KeyValueStorageService();
      if (responseData.token?.accessToken?.isNotEmpty ?? false) {
        keyValueStorageService.setAuthToken(
            responseData.token?.accessToken ?? '');
        AppRouter.pushNamed(Routes.HomeScreenRoute);
      }} else {
      loginStatus.value=signInResponse.status?.type??'';
        error.value = signInResponse.status?.message ?? '';
      }
    EasyLoading.dismiss();
    }

    Future<void> logOut() async {
    }

  Future<void> skipLogOut() async {
  }

  Future<void> deleteAccount() async {
  }

  Future<void> forgotPassword(String email) async {
  }

  Future<void> validateToken(String token, String email) async {

  }
  }



