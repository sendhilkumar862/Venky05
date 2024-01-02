import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/base_response.dart';
import '../../../../core/local_auth_services.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/utils/validators.dart';
import '../model/login_model.dart';
import '../model/refresh_model.dart';
import '../repository/auth_repositoriy.dart';
import '../repository/refresh_token_repository.dart';

class SignInController extends GetxController {
  RxString error = ''.obs;
  RxString emailErrorText = ''.obs;
  RxString loginError = ''.obs;
  RxString loginStatus = ''.obs;
  RxInt emailValid = 2.obs;
  RxBool isButtonDisabled = true.obs;
  RxBool isPasswordShow = true.obs;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final AuthRepositoryRepository _authRepositoryRepository =
      AuthRepositoryRepository();
  final RefreshTokenRepositoryRepository _refreshTokenRepositoryRepository =
      RefreshTokenRepositoryRepository();
  RxString authenticated = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchLocalAuth();
    super.onInit();
  }

  void validateEmail(String value) {
    loginStatus.value = '';

    if (value.isEmpty) {
      emailValid.value = 0;
      emailErrorText.value = 'pleaseEnter'.tr;
    } else if (Regexes.validateRegEx(
        emailController.text, Regexes.emailRegex)) {
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

  fetchLocalAuth() async {
    authenticated.value = await   LocaleManager.getValue(StorageKeys.authBiometric);
  }

  void onPasswordChanged(String value) {
    loginStatus.value = '';
    if (emailValid != 1) {
      isButtonDisabled.value = true;
    } else if (value.isEmpty) {
      isButtonDisabled.value = true;
    } else {
      isButtonDisabled.value = false;
    }
  }

  void onTapLoginSubmit(BuildContext context) {
    login(context);
  }

  Future<void> login(BuildContext context) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse signInResponse = await _authRepositoryRepository.sign(
        email: emailController.text, password: passwordController.text);
    if (signInResponse.status?.type == 'success') {
      final LoginModel responseData = LoginModel.fromJson(
          signInResponse.data!.item! as Map<String, dynamic>);
      if (responseData.token?.accessToken?.isNotEmpty ?? false) {
        LocaleManager.setAuthToken(responseData.token?.accessToken ?? '');
        LocaleManager.setValue(StorageKeys.profile, responseData.token?.role ?? '');
        AppRouter.pushNamedPopUntil(context, route: Routes.HomeScreenRoute);
      }
    } else {
      loginStatus.value = signInResponse.status?.type ?? '';
      error.value = signInResponse.status?.message ?? '';
    }
    EasyLoading.dismiss();
  }

  setLocalAuth(BuildContext context) async {
    final bool authenticatedStatus = await LocalAuth.authenticate();
    if (authenticatedStatus) {
      final String authToken =
          await LocaleManager.getValue(StorageKeys.authBiometric);
      LocaleManager.setValue(authToken, authToken??'');
      authenticated.value = authenticatedStatus.toString();
      refreshToken(context);
    }
  }

  Future<void> refreshToken(BuildContext context) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse signInResponse =
        await _refreshTokenRepositoryRepository.refreshToken();
    if (signInResponse.status?.type == 'success') {
      final RefreshModelClass responseData = RefreshModelClass.fromJson(
          signInResponse.data!.item! as Map<String, dynamic>);
      if (responseData.auth?.accessToken?.isNotEmpty ?? false) {
        LocaleManager
            .setAuthToken(responseData.auth?.accessToken ?? '');
        AppRouter.pushNamedPopUntil(context, route: Routes.HomeScreenRoute);
      }
    } else {
      loginStatus.value = signInResponse.status?.type ?? '';
      error.value = signInResponse.status?.message ?? '';
    }
    EasyLoading.dismiss();
  }
}
