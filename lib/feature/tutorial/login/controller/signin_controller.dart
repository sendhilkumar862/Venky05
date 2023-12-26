
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/base_response.dart';
import '../../../../core/local_auth_services.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../../../../repository/auth_repositoriy.dart';
import '../model/login_model.dart';
import '../model/refresh_model.dart';
import '../repository/refresh_token_repository.dart';


class SignInController extends GetxController {
  RxString error=''.obs;
  RxString emailErrorText = ''.obs;
  RxString loginError = ''.obs;
  RxString loginStatus = ''.obs;
  RxInt emailValid = 2.obs;
  RxBool isButtonDisabled = true.obs;
  RxBool isPasswordShow = true.obs;
  final KeyValueStorageService keyValueStorageService = KeyValueStorageService();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final AuthRepositoryRepository _authRepositoryRepository = AuthRepositoryRepository();
  final RefreshTokenRepositoryRepository _refreshTokenRepositoryRepository = RefreshTokenRepositoryRepository();
  RxString authenticated =''.obs;
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
  fetchLocalAuth()async{
    authenticated.value= await keyValueStorageService.getBioMetricStatus();
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
        keyValueStorageService.setAuthToken(
            responseData.token?.accessToken ?? '');
        AppRouter.pushNamedPopUntil( context,  route: Routes.HomeScreenRoute);
      }} else {
      loginStatus.value=signInResponse.status?.type??'';
        error.value = signInResponse.status?.message ?? '';
      }
    EasyLoading.dismiss();
    }
  setLocalAuth(BuildContext context)async{
    final bool authenticatedStatus = await LocalAuth.authenticate();
    if(authenticatedStatus){
      final String authToken= await keyValueStorageService.getBioMetricStatus();
      keyValueStorageService.setAuthBiometric(authToken);
      authenticated.value=authenticatedStatus.toString();
      refreshToken(context);
    }
  }
  Future<void> refreshToken(BuildContext context) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse signInResponse = await _refreshTokenRepositoryRepository.refreshToken(
       );
    if (signInResponse.status?.type == 'success') {
      final RefreshModelClass responseData = RefreshModelClass.fromJson(
          signInResponse.data!.item! as Map<String, dynamic>);
      if (responseData.auth?.accessToken?.isNotEmpty ?? false) {
        keyValueStorageService.setAuthToken(
            responseData.auth?.accessToken ?? '');
        AppRouter.pushNamedPopUntil( context,  route: Routes.HomeScreenRoute);
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



