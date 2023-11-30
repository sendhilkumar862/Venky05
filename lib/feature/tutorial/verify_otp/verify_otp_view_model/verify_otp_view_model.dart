import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hessah/feature/tutorial/verify_otp/model/otp_model.dart';
import 'package:mobx/mobx.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/countdown_timer/timer_count_down.dart';
import '../../../../product/base/model/base_view_model.dart';

import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';

part 'verify_otp_view_model.g.dart';

class VerifyOtpViewModel = _VerifyOtpViewModelBase with _$VerifyOtpViewModel;

abstract class _VerifyOtpViewModelBase extends BaseViewModel with Store {
  @observable
  CountdownController controller = CountdownController(autoStart: true);

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    final KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    currentProfile =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.profile);
    logs('current profile --> $currentProfile');
    controller.start();
  }

  @observable
  Map enteredMail = <String, dynamic>{};

  @observable
  String currentProfile = '';

  @observable
  bool isCorrect = true;

  @observable
  String enteredOTP = '';

  @observable
  bool isMobileNumber = false;

  @observable
  Map<String, dynamic> arguments = <String, dynamic>{'userId': ''};

  @action
  bool onChange(String value) {
    if (value == enteredOTP) {
      isCorrect = true;
      return isCorrect;
    } else {
      isCorrect = false;
      return isCorrect;
    }
  }

  @action
  Future<void> verifyOtp() async {
    logs('Eneterrrrr-->');
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);

    Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        'userId': "${arguments['userId']}",
        'otpId': "${arguments['otp_id']}",
        'otp': enteredOTP
      };

      logs('body -->$body');
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/email/verify-otp',
        data: body,
      );
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        logs(response.data.toString());
        otpModel = OtpModel.fromJson(response.data);

        isCorrect = otpModel.status!.type == 'success';
        // final Map<String, dynamic> arguments = <String, dynamic>{'userId': "${arguments['id']}"};
        if (otpModel.status!.type == 'success') {
          if (currentProfile == 'Tutor') {
            AppRouter.pushNamed(Routes.mobileView, args: arguments);
          } else {
            AppRouter.pushNamed(Routes.userInfoView, args: arguments);
          }
        }
        logs('isCorrect--> $isCorrect');
        enteredOTP = '';
      } else {
        EasyLoading.dismiss();
        logs('Error: ${response.statusCode}');
      }
    } on DioException catch (error) {
      EasyLoading.dismiss();
      AppUtils.showFlushBar(
        context: AppRouter.navigatorKey.currentContext!,
        message: error.response?.data['status']['message'] ?? 'Error occured',
      );
      logs('Error: $error');
    } catch (error) {
      EasyLoading.dismiss();
      isCorrect = false;
      logs('Error: $error');
    }
  }

  @action
  Future<void> verifyOtpMobile() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        'userId': "${arguments['userId']}",
        'otpId': "${arguments['otp_id']}",
        'otp': enteredOTP
      };
  
      logs('body -->$body');
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/mobile/verify-otp',
        data: body,
      );
  
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        logs(response.data.toString());
  
        otpModel = OtpModel.fromJson(response.data);
  
        // Now you can access the parsed data using the otpModel object
        logs('Parsed ID: ${otpModel.data!.item!.id}');
        logs('Status Type: ${otpModel.status!.type}');
        logs('Status Message: ${otpModel.status!.message}');
        isCorrect = otpModel.status!.type == 'success';
  
        if (otpModel.status!.type == 'success') {
          AppRouter.pushNamed(Routes.userInfoView, args: arguments);
        }
  
        logs('isCorrect--> $isCorrect');
        enteredOTP = '';
      } else {
        EasyLoading.dismiss();
        logs('Error: ${response.statusCode}');
      }
    } on DioException catch (error) {
      EasyLoading.dismiss();
      AppUtils.showFlushBar(
        context: AppRouter.navigatorKey.currentContext!,
        message: error.response?.data['status']['message'] ?? 'Error occured',
      );
      logs('Error: $error');
    } catch (error) {
      EasyLoading.dismiss();
      logs('Error: $error');
    }
  }

  @observable
  OtpModel otpModel = const OtpModel();

  @action
  void onTapSubmit() {
    if (arguments['isScreen']) {
      verifyOtp();
    } else {
      verifyOtpMobile();
    }
  }
}
