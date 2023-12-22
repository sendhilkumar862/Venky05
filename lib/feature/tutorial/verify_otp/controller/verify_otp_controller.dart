import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../custom/countdown_timer/timer_count_down.dart';
import '../../../../product/utils/validators.dart';

class VerifyOtpController extends  GetxController{
  CountdownController timerController = CountdownController(autoStart: true);
  Map enteredMail = <String, dynamic>{};
  String currentProfile = '';
  bool isCorrect = true;
  String enteredOTP = '';
  bool isTimerRunning = false;
  bool isMobileNumber = false;
  Map<String, dynamic> arguments = <String, dynamic>{'userId': ''};
  String otpId = '';

  bool onChange(String value) {
    if (value == enteredOTP) {
      isCorrect = true;
      return isCorrect;
    } else {
      isCorrect = false;
      return isCorrect;
    }
  }


}