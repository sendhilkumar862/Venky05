import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/countdown_timer/timer_count_down.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../../verify_otp/model/otp_model.dart';

class MobileOTPController extends GetxController{

  CountdownController controller = CountdownController(autoStart: true);



  @override
  void onInit() {
    super.onInit();
    final KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    currentProfile.value =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ??
            '';
    logs('current profile --> $currentProfile');
    controller.start();
  }


  RxString currentProfile = ''.obs;


  RxBool isCorrect = true.obs;


  RxString enteredOTP = ''.obs;


  RxMap<String, dynamic> arguments = <String, dynamic>{'userId': ''}.obs;

  // @action
  // bool onChange(String value) {
  //   if (value == enteredOTP) {
  //     isCorrect = true;
  //     return isCorrect;
  //   } else {
  //     isCorrect = false;
  //     return isCorrect;
  //   }
  // }


  Future<void> verifyOtp() async {
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

        // otpModel = otpModel.fromJson(response.data);

        // Now you can access the parsed data using the otpModel object
        logs('Parsed ID: ${otpModel.value.data!.item!.id}');
        logs('Status Type: ${otpModel.value.status!.type}');
        logs('Status Message: ${otpModel.value.status!.message}');
        isCorrect.value = otpModel.value.status!.type == 'success';

        if (otpModel.value.status!.type == 'success') {
          AppRouter.pushNamed(Routes.userInfoView, args: arguments);
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
      logs('Error: $error');
    } catch (error) {
      EasyLoading.dismiss();
      logs('Error: $error');
    }
  }


  Rx<OtpModel> otpModel = const OtpModel().obs;


  void onTapSubmit() {
    verifyOtp();
  }
}
