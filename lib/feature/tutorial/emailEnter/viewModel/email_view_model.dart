import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';

import '../model/email_enter_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/constants/enums/app_register_status_enums.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../../../product/utils/validators.dart';
import 'model/email_enter_model.dart';

part 'email_view_model.g.dart';

class EmailViewModel = _EmailViewModelBase with _$EmailViewModel;

abstract class _EmailViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    KeyValueStorageBase.init();
  }

  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();

  @observable
  Map<String, dynamic> arguments = <String, dynamic>{
    'userId': '',
    'otp_id': '',
  };

  @action
  Future<void> registerMail() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        'email': emailController.text,
        'role': keyValueStorageBase.getCommon(
            String, KeyValueStorageService.profile),
      };
      logs(body.toString());
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/register/email',
        data: body,
      );

      if (response.statusCode == 200) {
        final EmailEnterModel data = EmailEnterModel.fromJson(response.data);
        if (data.status.type == 'success') {
          logs('registered ${data.status.type}');
          arguments['userId'] = data.data.item.userId;
          final String status = data.data.item.status;
          if (status == RegistrationStatus.MOBILE.value) {
            EasyLoading.dismiss();
            AppRouter.pushNamed(Routes.mobileView, args: arguments);
          } else if(status == RegistrationStatus.EMAIL.value) {
              sendOTP(data.data.item.userId.toString());    
          } else if (status == RegistrationStatus.PROFILE_INCOMPLETE.value) {
              EasyLoading.dismiss();
              // redirect to last step of registration....
              AppRouter.pushNamed(Routes.userInfoView, args: arguments);
          }
        }
      } else {
        EasyLoading.dismiss();
        logs('error not response');
      }
    } on DioException catch (error) {
      EasyLoading.dismiss();
      data = EmailEnterModel.fromJson(error.response!.data);
      registerWarning = data.status!.type == 'error';
      registerWarningMessage = data.status!.message!;
      logs('registerMail error --> ${registerWarning}');
    }
  }

  @action
  Future<void> sendOTP(String id) async {
    // viewModelContext.loaderOverlay.show();
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
        registerWarning = response!.data['status']['type'] == 'error';
        arguments['otp_id'] = response.data['data']['item']['otp_id'];

        AppRouter.pushNamed(Routes.emailOtpView, args: arguments);
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
      registerWarning = error.response!.data['status']['type'] =='error';
      registerWarningMessage = error.response!.data['status']['message'];
      logs('error message--> ${error.response!.data['status']['message']}');
      logs('SendOtp error');
    }
  }

  @observable
  TextEditingController emailController =
      TextEditingController();

  @observable
  String emailErrorText = '';

  @observable
  int emailValid = 2;

  @action
  void validateEmail(String value) {
    registerWarning = false;

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
  void onTapEmailSubmit() {
    if (emailValid == 1) {
      registerMail();
    }
  }
}
