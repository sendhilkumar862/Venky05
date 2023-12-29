import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/countdown_timer/timer_count_down.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../../../home/controller/home_controller.dart';
import '../model/otp_model.dart';

class VerifyOtpController extends  GetxController{

  CountdownController timerController = CountdownController(autoStart: true);



  @override
  void onInit() {
    super.onInit();
    final KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    currentProfile.value = keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ?? '';
    timerController.start();
    isTimerRunning.value = true;
    logs('current profile --> $currentProfile');
  }


  RxMap enteredMail = <String, dynamic>{}.obs;


  RxString currentProfile = ''.obs;


  RxBool isCorrect = true.obs;


  RxString enteredOTP = ''.obs;


  RxBool isTimerRunning = false.obs;


  RxBool isMobileNumber = false.obs;


  Map<String, dynamic> arguments = <String, dynamic>{'userId': '','changeMobileNumberScreen':''};


  RxString otpId = ''.obs;


  bool onChange(String value) {
    if (value == enteredOTP.value) {
      isCorrect.value = true;
      return isCorrect.value;
    } else {
      isCorrect.value = false;
      return isCorrect.value;
    }
  }


  Future<void> verifyOtp() async {
    logs('Mail OTP verification');
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        'userId': "${arguments['userId']}",
        'otpId': otpId.value,
        'otp': enteredOTP.value,

      };

      logs('body :-->$body');
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/email/verify-otp',
        data: body,
      );
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        otpModel.value = OtpModel.fromJson(response.data);

        isCorrect.value = otpModel.value.status!.type == 'success';
        if (otpModel.value.status!.type == 'success') {
          timerController.pause();
          if (currentProfile == 'Tutor') {
            AppRouter.popAndPushNamed(Routes.mobileView, args: arguments);
          } else {
            AppRouter.popAndPushNamed(Routes.userInfoView, args: arguments);
          }
        }
        enteredOTP.value = '';
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
      isCorrect.value = false;
      logs('Error: $error');
    }
  }

  Future<void> verifyOtpMobile(BuildContext context, bool? isUpdateStatus) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final Dio dio = Dio();
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        'userId': "${arguments['userId']}",
        'otpId': otpId.value,
        'otp': enteredOTP.value,
        if(isUpdateStatus!=null && isUpdateStatus)
          ...{"isMobileUpdation":true}
      };

      logs('body -->$body');
      final Response response = await dio.post(
        'http://167.99.93.83/api/v1/users/mobile/verify-otp',
        data: body,
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        otpModel.value = OtpModel.fromJson(response.data);

        logs('Parsed ID: ${otpModel.value.data!.item!.id}');
        logs('Status Type: ${otpModel.value.status!.type}');
        logs('Status Message: ${otpModel.value.status!.message}');
        isCorrect.value = otpModel.value.status!.type == 'success';

        if (otpModel.value.status!.type == 'success') {
          timerController.pause();
          if (arguments['isPreLogin'] ?? false) {
            AppRouter.popAndPushNamed(Routes.userInfoView, args: arguments);
          } else {
            final HomeController homeController=Get.find();
            homeController.fetchData();
            popupScreen(context);
          }


          //(arguments['changeMobileNumberScreen']!=null&&(arguments['changeMobileNumberScreen']=='add'|| arguments['changeMobileNumberScreen']=='change'))?popupScreen(context):AppRouter.popAndPushNamed(Routes.userInfoView, args: arguments);
        }

        logs('isCorrect--> $isCorrect');
        enteredOTP.value = '';
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
        isTimerRunning.value = true;
        otpId.value = response.data['data']['item']['otp_id'].toString();
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


  void reSendOtp() {
    reSendEmailOTP(arguments['userId'].toString());
  }


  Rx<OtpModel> otpModel = const OtpModel().obs;


  void onTapSubmit(BuildContext context) {
    if (arguments['isScreen']) {
      verifyOtp();
    } else {
      verifyOtpMobile(context,arguments['isMobileUpdation']);
    }
  }
}
