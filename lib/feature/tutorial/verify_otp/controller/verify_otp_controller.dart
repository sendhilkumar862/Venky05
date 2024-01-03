import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../config/routes/route.dart';

import '../../../../core/base_response.dart';
import '../../../../custom/countdown_timer/timer_count_down.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/utils/validators.dart';
import '../../../home/controller/home_controller.dart';
import '../model/otp_model.dart';
import '../model_request/verify_mobile_update_otp_request_model.dart';
import '../model_request/verify_otp_request_model.dart';
import '../repository/resend_otp_repository.dart';
import '../repository/varify_mobile_update_otp_repository.dart';
import '../repository/verify_otp_repository.dart';

class VerifyOtpController extends GetxController {
  CountdownController timerController = CountdownController(autoStart: true);
  final VerifyMobileUpdateOTPRepository _mobileUpdateOTPRepository =
      VerifyMobileUpdateOTPRepository();
  final VerifyOTPRepository _verifyOTPRepository = VerifyOTPRepository();
  final ResendOTPRepository _resendOTPRepository = ResendOTPRepository();

  @override
  void onInit() {
    super.onInit();

    currentProfile.value =
        LocaleManager.getValue( StorageKeys.profile) ??'';
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

  Map<String, dynamic> arguments = <String, dynamic>{
    'userId': '',
    'changeMobileNumberScreen': ''
  };

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

  Future<void> verifyOtp(BuildContext context, bool isMobile) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    try {
      final BaseResponse otpResponse = await _verifyOTPRepository.verifyOTPSend(
          verifyOTPRequestModel: VerifyOTPRequestModel(
              otp: enteredOTP.value,
              otpId: "${arguments['otp_id']}",
              userId: "${arguments['userId']}"),
          isMobile: isMobile);

      if (otpResponse.status?.type == 'success') {
        isCorrect.value = true;
        enteredOTP.value = '';
        timerController.pause();
        if (isMobile) {
          if (arguments['isPreLogin'] ?? false) {
            Get.offAndToNamed(Routes.userInfoView, arguments: arguments);
            // AppRouter.popAndPushNamed(Routes.userInfoView, args: arguments);
          } else {
            final HomeController homeController = Get.find();
            homeController.fetchData();
            popupScreen(context);
          }
        } else {
          if (currentProfile == 'Tutor') {
            Get.offAndToNamed(Routes.mobileView, arguments: arguments);
          } else {
            Get.offAndToNamed(Routes.userInfoView, arguments: arguments);
          }
        }
      } else {
        isCorrect.value = false;
        AppUtils.showFlushBar(
          context: Routes.navigatorKey.currentContext!,
          message: otpResponse.status?.message ?? 'Error occured',
        );
      }
    } on DioException catch (error) {
      isCorrect.value = false;
      AppUtils.showFlushBar(
        context: Routes.navigatorKey.currentContext!,
        message: error.response?.data['status']['message'] ?? 'Error occured',
      );
      logs('Error: $error');
    } catch (error) {
      logs('Error: $error');
    }
    EasyLoading.dismiss();
  }

  Future<void> verifyOtpMobileUpdate(
    BuildContext context,
  ) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    try {
      final BaseResponse otpResponse =
          await _mobileUpdateOTPRepository.verifyMobileUpdateOTPSend(
              verifyMobileUpdateOTPRequestModel:
                  VerifyMobileUpdateOTPRequestModel(
                      otp: enteredOTP.value,
                      otpId: "${arguments['otp_id']}",
                      userId: "${arguments['userId']}",
                      isMobileUpdation: true));
      if (otpResponse.status?.type == 'success') {
        isCorrect.value = true;
        enteredOTP.value = '';
        timerController.pause();
        if (arguments['isPreLogin'] ?? false) {
          Get.offAndToNamed(Routes.userInfoView, arguments: arguments);
        } else {
          final HomeController homeController = Get.find();
          homeController.fetchData();
          popupScreen(context);
        }
      } else {
        isCorrect.value = false;
        AppUtils.showFlushBar(
          context: Routes.navigatorKey.currentContext!,
          message: otpResponse.status?.message ?? 'Error occured',
        );
      }
    } on DioException catch (error) {
      isCorrect.value = false;
      AppUtils.showFlushBar(
        context: Routes.navigatorKey.currentContext!,
        message: error.response?.data['status']['message'] ?? 'Error occured',
      );
      logs('Error: $error');
    } catch (error) {
      logs('Error: $error');
    }
    EasyLoading.dismiss();
  }

  Future popupScreen(BuildContext context) {
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
          content: arguments['changeMobileNumberScreen'] == 'add'
              ? 'youHaveSuccessfullyAddedMobile'.tr
              : 'youHaveSuccessfullyChangedMobile'.tr,
          isRouting: 'route',
        );
      },
    );
  }

  Future<void> reSendEmailOTP(String id) async {
    showLoading();
    try {
      final Map<String, dynamic> emailOtpBody = <String, dynamic>{
        'userId': id,
      };

      final Map<String, dynamic> mobileOtpBody = <String, dynamic>{
        'userId': id,
        'mobile': arguments['mobile'],
        'countryCode': arguments['countryCode']
      };
      final BaseResponse otpResponse = await _resendOTPRepository.resendOTPSend(
          bodyData: arguments['isScreen'] ? emailOtpBody : mobileOtpBody);
      if (otpResponse.status?.type == 'success') {
        timerController.restart();
        isTimerRunning.value = true;
        final Map<String, dynamic> itemData =
            otpResponse.data!.item! as Map<String, dynamic>;
        otpId.value = itemData['otp_id'].toString();
        logs('otp ID--> $otpId');
        AppUtils.showFlushBar(
          icon: Icons.check_circle_outline_rounded,
          iconColor: Colors.green,
          context: Routes.navigatorKey.currentContext!,
          message: otpResponse.status?.message ?? 'Error occured',
        );
      } else {
        isCorrect.value = false;
        AppUtils.showFlushBar(
          context: Routes.navigatorKey.currentContext!,
          iconColor: Colors.red,
          message: otpResponse.status?.message ?? 'Error occured',
        );
      }
    } on DioException catch (error) {
      isCorrect.value = false;
      AppUtils.showFlushBar(
        context: Routes.navigatorKey.currentContext!,
        message: error.response?.data['status']['message'] ?? 'Error occured',
      );
      logs('Error: $error');
    } catch (error) {
      logs('Error: $error');
    }
    EasyLoading.dismiss();
  }

  void reSendOtp() {
    reSendEmailOTP(arguments['userId'].toString());
  }

  Rx<OtpModel> otpModel = const OtpModel().obs;

  void onTapSubmit(BuildContext context) {
    if (arguments['isScreen']) {
      verifyOtp(context, false);
    } else {
      if (arguments['isMobileUpdation'] != null &&
          arguments['isMobileUpdation']) {
        verifyOtpMobileUpdate(context);
      } else {
        verifyOtp(context, true);
      }
    }
  }
}
