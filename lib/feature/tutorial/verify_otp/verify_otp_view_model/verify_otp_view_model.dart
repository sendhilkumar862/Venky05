import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;
import 'package:mobx/mobx.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/countdown_timer/timer_count_down.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../../../home/controller/home_controller.dart';
import '../../../setting_view/view/setting_view.dart';
import '../model/otp_model.dart';

part 'verify_otp_view_model.g.dart';

class VerifyOtpViewModel = _VerifyOtpViewModelBase with _$VerifyOtpViewModel;

abstract class _VerifyOtpViewModelBase extends BaseViewModel with Store {
  @observable
  CountdownController timerController = CountdownController(autoStart: true);

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    final KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    currentProfile = keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ?? '';
    timerController.start();
    isTimerRunning = true;
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

  @observable
  bool isTimerRunning = false;

  @observable
  bool isMobileNumber = false;

  @observable
  Map<String, dynamic> arguments = <String, dynamic>{'userId': '','changeMobileNumberScreen':''};

  @observable
  String otpId = '';

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
    logs('Mail OTP verification');
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        'userId': "${arguments['userId']}",
        'otpId': otpId,
        'otp': enteredOTP
      };

      logs('body :-->$body');
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/email/verify-otp',
        data: body,
      );
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        otpModel = OtpModel.fromJson(response.data);

        isCorrect = otpModel.status!.type == 'success';
        if (otpModel.status!.type == 'success') {
          timerController.pause();
          if (currentProfile == 'Tutor') {
            AppRouter.popAndPushNamed(Routes.mobileView, args: arguments);
          } else {
            AppRouter.popAndPushNamed(Routes.userInfoView, args: arguments);
          }
        }
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
      // isCorrect = false;

      logs('Error: $error');
    } catch (error) {
      EasyLoading.dismiss();
      isCorrect = false;
      logs('Error: $error');
    }
  }

  @action
  Future<void> verifyOtpMobile(BuildContext context) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        'userId': "${arguments['userId']}",
        'otpId': otpId,
        'otp': enteredOTP
      };

      logs('body -->$body');
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/mobile/verify-otp',
        data: body,
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        otpModel = OtpModel.fromJson(response.data);

        logs('Parsed ID: ${otpModel.data!.item!.id}');
        logs('Status Type: ${otpModel.status!.type}');
        logs('Status Message: ${otpModel.status!.message}');
        isCorrect = otpModel.status!.type == 'success';

        if (otpModel.status!.type == 'success') {
          timerController.pause();
          final HomeController _homeController=Get.find();
          _homeController.fetchData();

          (arguments['changeMobileNumberScreen']!=null&&(arguments['changeMobileNumberScreen']=='add'|| arguments['changeMobileNumberScreen']=='change'))?popupScreen(context):AppRouter.popAndPushNamed(Routes.userInfoView, args: arguments);
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
      //isCorrect = false;
      logs('Error: $error');
    } catch (error) {
      EasyLoading.dismiss();
      logs('Error: $error');
    }
  }

  Future popupScreen(BuildContext context){
   return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 30,
        // here increase or decrease in width
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (BuildContext context) {
        return SuccessFailsInfoDialog(
          title: 'success'.tr,
          buttonTitle: 'done'.tr,
          content: arguments['changeMobileNumberScreen']=='add'?'youHaveSuccessfullyAddedMobile'.tr:'youHaveSuccessfullyChangedMobile'.tr,
          isRouting: 'route',
        );
      },
    );
  }

  @action
  Future<void> reSendEmailOTP(String id) async {
    showLoading();
    logs('Send OTP Entered');
    final Dio dio = Dio();
    try {
      final Map emailOtpBody = <String, dynamic>{
        'userId': id,
      };

      final Map mobileOtpBody = <String, dynamic>{
        'userId': id,
        'mobile': arguments['mobile'],
        'countryCode': arguments['countryCode']
      };

      logs('resend email OTP body--> $emailOtpBody');
      logs('resend mobile OTP body--> $mobileOtpBody');

      final Response response = await dio.post(
        (arguments['isScreen'])
            ? 'http://167.99.93.83/api/v1/users/email/send-otp'
            : 'http://167.99.93.83/api/v1/users/mobile/send-otp',
        data: (arguments['isScreen']) ? emailOtpBody : mobileOtpBody,
      );

      logs('status Code --> ${response.statusCode}');
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        timerController.restart();
        isTimerRunning = true;
        otpId = response.data['data']['item']['otp_id'].toString();
        logs('otp ID--> $otpId');
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
      //registerWarning = error.response!.data['status']['type'] == 'error';
      //registerWarningMessage = error.response!.data['status']['message'];
      logs('error message--> ${error.response!.data['status']['message']}');
      logs('SendOtp error');
    }
  }

  @action
  void reSendOtp() {
    reSendEmailOTP(arguments['userId'].toString());
  }

  @observable
  OtpModel otpModel = const OtpModel();

  @action
  void onTapSubmit(BuildContext context) {
    if (arguments['isScreen']) {
      verifyOtp();
    } else {
      verifyOtpMobile(context);
    }
  }
}
