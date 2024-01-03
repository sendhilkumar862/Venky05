import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../config/routes/route.dart';

import '../../../../core/base_response.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/constants/enums/app_register_status_enums.dart';
import '../../../../product/utils/validators.dart';
import '../model/email_enter_model.dart';
import '../model/email_enter_request.dart';
import '../repository/email_otp_repository.dart';
import '../repository/register_mail_repository.dart';


class EmailEnterController extends GetxController{


  @override
  void onInit() {
    super.onInit();
  }
  final RegisterMailRepositoryRepository _registerMailRepositoryRepository=RegisterMailRepositoryRepository();
  final SendOTPRepositoryRepository _sendOTPRepositoryRepository =SendOTPRepositoryRepository();


  Map<String, dynamic> arguments = <String, dynamic>{
    'userId': '',
    'otp_id': '',
    'isScreen': false,
  };


  Rx<EmailEnterModel> data = const EmailEnterModel().obs;

  Future<void> registerMail() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse registerEmailResponse = await _registerMailRepositoryRepository.registerMail(
        emailEnterModel: EmailEnterRequest(role:LocaleManager.getValue( StorageKeys.profile),email: emailController.text, )
       );
    if (registerEmailResponse.status?.type == 'success') {
      var emailRegisterData =
          registerEmailResponse.data!.item! as Map<String, dynamic>;
      final EmailEnterModel emailEnterModel =
          EmailEnterModel.fromJson(emailRegisterData);
      arguments['userId'] = emailEnterModel.userId ?? '';
      final Object status = emailEnterModel.status ?? '';
      if (status == RegistrationStatus.MOBILE.value) {
        Get.toNamed(Routes.mobileView, arguments: arguments);
      } else if (status == RegistrationStatus.EMAIL.value) {
        sendOTP(emailEnterModel.userId.toString());
      } else if (status == RegistrationStatus.PROFILE_INCOMPLETE.value) {
        Get.toNamed(Routes.userInfoView, arguments: arguments);
      } else {
        registerWarning.value = true;
        registerWarningMessage.value =
            'The email address you provided is already registered in our system.';
      }
    } else {
      registerWarning.value = true;
      registerWarningMessage.value = registerEmailResponse.status?.message??'';
    }
    EasyLoading.dismiss();
  }

  Future<void> sendOTP(String id) async {
    showLoading();
    final BaseResponse sendOTPResponse =
        await _sendOTPRepositoryRepository.sendOTP(id: id);
    if (sendOTPResponse.status?.type == 'success') {
      final Map<String, dynamic> emailRegisterData =
          sendOTPResponse.data!.item! as Map<String, dynamic>;
      arguments['otp_id'] = emailRegisterData['otp_id'];
      arguments['isScreen'] = true;
      arguments['isPreLogin'] = true;
      arguments['email'] = emailController.text;
      //   arguments['contact'] = emailController.text;
      AppUtils.showFlushBar(
        icon: Icons.check_circle_outline_rounded,
        iconColor: Colors.green,
        context: Routes.navigatorKey.currentContext!,
        message: sendOTPResponse.status?.message ?? 'Error occured',
      );
      Get.toNamed(Routes.verifyOtpView, arguments: arguments);
    } else {
      registerWarning.value = true;
      registerWarningMessage.value =
          sendOTPResponse.status?.message ?? 'Error occured';
      AppUtils.showFlushBar(
        icon: Icons.check_circle_outline_rounded,
        iconColor: Colors.red,
        context: Routes.navigatorKey.currentContext!,
        message: sendOTPResponse.status?.message ?? 'Error occured',
      );
    }
    EasyLoading.dismiss();
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
    } else if (Regexes.validateRegEx(
        emailController.text, Regexes.emailRegex)) {
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
