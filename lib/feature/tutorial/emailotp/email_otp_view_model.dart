import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../product/cache/locale_manager.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../../../product/network/networking/api_service.dart';
import '../../../product/network/networking/dio_service.dart';
import '../../../product/utils/validators.dart';
import 'model/otp_model.dart';

part 'email_otp_view_model.g.dart';

class EmailOtpViewModel = _EmailOtpViewModelBase with _$EmailOtpViewModel;

abstract class _EmailOtpViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    currentProfile =
        keyValueStorageBase.getCommon(KeyValueStorageService.profile);
    logs('current profile --> $currentProfile');
  }

  @observable
  Map enteredMail = <String, dynamic>{};

  @observable
  String currentProfile = '';

  @observable
  bool isCorrect = true;

  @observable
  String enteredOTP = '';

  @action
  Future<void> verifyOtp() async {
    Dio dio = Dio();
    try {
      Map<String, dynamic> body = {
        'userId': "${enteredMail['id']}",
        'otpId': "${enteredMail['otp_id']}",
        'otp': enteredOTP
      };

      logs('body -->$body');
      final response = await dio.post(
        'http://167.99.93.83/api/v1/users/email/verify-otp',
        data: body,
      );

      if (response.statusCode == 200) {
        logs(response.data.toString());

        otpModel = OtpModel.fromJson(response.data);

        // Now you can access the parsed data using the otpModel object
        logs('Parsed ID: ${otpModel.data!.item!.id}');
        logs('Status Type: ${otpModel.status!.type}');
        logs('Status Message: ${otpModel.status!.message}');
        isCorrect = otpModel.status!.type == 'success';

        if (otpModel.status!.type == 'success') {
          if (currentProfile == 'Teacher') {
            AppRouter.pushNamed(Routes.mobileView);
          } else {
            AppRouter.pushNamed(Routes.userInfoView);
          }
        }

        logs('isCorrect--> $isCorrect');
        enteredOTP = '';
      } else {
        logs('Error: ${response.statusCode}');
      }
    } catch (error) {
      logs('Error: $error');
    }
  }

  @observable
  OtpModel otpModel = const OtpModel();

  @action
  void onTapSubmit() {
    verifyOtp();
  }
}
