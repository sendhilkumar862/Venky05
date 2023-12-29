import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/base/model/base_model.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/constants/enums/app_register_status_enums.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../model/email_enter_model.dart';

class EmailEnterController extends GetxController{


  @override
  void onInit() {
    super.onInit();
    KeyValueStorageBase.init();
  }

  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();


  Map<String, dynamic> arguments = <String, dynamic>{
    'userId': '',
    'otp_id': '',
  };


  Rx<EmailEnterModel> data = EmailEnterModel().obs;


  Future<void> registerMail() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        'email': emailController.text,
        'role': keyValueStorageBase.getCommon(String, KeyValueStorageService.profile),
      };
      logs(body.toString());
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/register/email',
        data: body,
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final BaseResponse<EmailEnterModel> baseResponse =
        BaseResponse<EmailEnterModel>.fromJson(response.data, EmailEnterModel.fromJson);
        if (baseResponse.status.type == 'success') {
          arguments['userId'] = baseResponse.data.item?.userId ?? '';
          final Object status = baseResponse.data.item?.status ?? '';
          if (status == RegistrationStatus.MOBILE.value) {
            AppRouter.pushNamed(Routes.mobileView, args: arguments);
          } else if (status == RegistrationStatus.EMAIL.value) {
            sendOTP(baseResponse.data.item!.userId.toString());
          } else if (status == RegistrationStatus.PROFILE_INCOMPLETE.value) {
            AppRouter.pushNamed(Routes.userInfoView, args: arguments);
          } else {
            registerWarning.value = true;
            registerWarningMessage.value = 'The email address you provided is already registered in our system.';
          }
        } else {
          registerWarning.value = true;
          registerWarningMessage.value = baseResponse.status.message;
        }
      } else {
        EasyLoading.dismiss();
        logs('error not response');
      }
    } on DioException catch (error) {
      EasyLoading.dismiss();
      final BaseResponse<EmailEnterModel> baseResponse =
      BaseResponse<EmailEnterModel>.fromJson(error.response!.data, EmailEnterModel.fromJson);
      registerWarning.value = baseResponse.status!.type == 'error';
      registerWarningMessage.value = baseResponse.status!.message!;
      logs('registerMail error --> $registerWarning');
    }
  }


  Future<void> sendOTP(String id) async {
    showLoading();
    logs('Send OTP Entered');
    final Dio dio = Dio();
    try {
      final Map body = <String, dynamic>{
        'userId': id,
      };
      logs('body--> $body');
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/email/send-otp',
        data: body,
      );
      logs('status Code --> ${response.statusCode}');
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        registerWarning.value = response!.data['status']['type'] == 'error';
        arguments['otp_id'] = response.data['data']['item']['otp_id'];
        arguments['isScreen'] = true;
        arguments['isPreLogin'] = true;
        arguments['email']=emailController.text;
        //   arguments['contact'] = emailController.text;

        AppRouter.pushNamed(Routes.verifyOtpView, args: arguments);
        AppUtils.showFlushBar(
          icon: Icons.check_circle_outline_rounded,
          iconColor: Colors.green,
          context: AppRouter.navigatorKey.currentContext!,
          message: response.data['status']['message'] ?? 'Error occured',
        );
      } else {
        EasyLoading.dismiss();
        logs('error not response');
      }
    } on DioException catch (error) {
      EasyLoading.dismiss();
      registerWarning.value = error.response!.data['status']['type'] == 'error';
      registerWarningMessage = error.response!.data['status']['message'];
      logs('error message--> ${error.response!.data['status']['message']}');
      logs('SendOtp error');
    }
  }


  TextEditingController emailController = TextEditingController();


  RxString emailErrorText = ''.obs;

  RxInt emailValid = 2.obs;


  RxBool registerWarning = false.obs;


  RxString registerWarningMessage = ''.obs;


  void validateEmail(String value) {
    registerWarning.value = false;

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
  }


  void onTapEmailSubmit() {
    if (emailValid == 1) {
      registerMail();
    }
  }
}