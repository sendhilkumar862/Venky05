import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../product/cache/locale_manager.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../tutorial/view/language_view.dart';

part 'email_otp_view_model.g.dart';

class EmailOtpViewModel = _EmailOtpViewModelBase with _$EmailOtpViewModel;

abstract class _EmailOtpViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    currentProfile = LocaleManager.instance.getIntValue(LocaleManager.profile);
  }

  @observable
  String enteredMail = '';

  @observable
  int currentProfile = 0;

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
      if (currentProfile == 0) {
        AppRouter.pushNamed(Routes.mobileView);
      } else {
        AppRouter.pushNamed(Routes.userInfoView);
      }
    }
    //enteredOTP = '';
  }
}
