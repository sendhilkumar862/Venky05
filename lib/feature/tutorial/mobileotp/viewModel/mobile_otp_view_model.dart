import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../product/base/model/base_view_model.dart';


part 'mobile_otp_view_model.g.dart';

class MobileOtpViewModel = _MobileOtpViewModelBase with _$MobileOtpViewModel;

abstract class _MobileOtpViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  @observable
  String enteredMobile = '';

  @observable
  bool isCorrect = true;

  @observable
  String enteredOTP = '';

  @action
  bool onChange(String value) {
    if (value == '1234') {
      isCorrect = true;
      return isCorrect;
    } else {
      isCorrect = false;
      return isCorrect;
    }
  }

  @action
  void onTapSubmit() {
    onChange(enteredOTP);
    if (enteredOTP == '1234') {
      AppRouter.pushNamed(Routes.userInfoView);
    }
  }
}
