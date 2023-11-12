import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/utils/validators.dart';
import '../../tutorial/view/language_view.dart';

part 'email_view_model.g.dart';

class EmailViewModel = _EmailViewModelBase with _$EmailViewModel;

abstract class _EmailViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
  }

  //========email========//
  @observable
  TextEditingController emailController = TextEditingController();


  @observable
  String emailErrorText = '';

  @observable
  int emailValid = 2;

  @action
  void validateEmail(String value) {
    if (value!.isEmpty) {
      emailValid = 0;
      emailErrorText = 'pleaseEnter'.tr();
    } else if (Regexes.validateRegEx(
        emailController.text, Regexes.emailRegex)) {
      emailValid = 0;
      emailErrorText = 'enterValidEmail'.tr();
    } else {
      emailValid = 1;
      emailErrorText = '';
      logs('error--> $emailValid');
    }
  }

  @action
  void onTapEmailSubmit() {
    if (emailValid == 1) {
      AppRouter.pushNamed(Routes.emailOtpView, args: emailController.text);
    }
  }

}
