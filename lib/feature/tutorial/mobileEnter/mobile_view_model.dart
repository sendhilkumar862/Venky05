import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../product/cache/locale_manager.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../../../product/utils/validators.dart';

part 'mobile_view_model.g.dart';

class MobileViewModel = _MobileViewModelBase with _$MobileViewModel;

abstract class _MobileViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    var currentProfile =
        keyValueStorageBase.getCommon(KeyValueStorageService.profile);
  }

  //========mobile========//

  @observable
  TextEditingController mobileController = TextEditingController();

  @observable
  String mobileErrorText = '';

  @observable
  int mobileValid = 2;

  @action
  void validateMobile(String value) {
    if (value!.isEmpty) {
      mobileValid = 0;
      mobileErrorText = 'pleaseEnterMobile'.tr();
    } else if (mobileController.text.length != 8) {
      mobileValid = 0;
      mobileErrorText = 'kuwaitiNumber'.tr();
    }
    // else if (Regexes.validateRegEx(
    //     mobileController.text, Regexes.contactRegex)) {
    //   mobileValid = 0;
    //   mobileErrorText = 'Kuwaiti number should be start with 4,5,6 and 9';
    //}
    else {
      mobileValid = 1;
      mobileErrorText = '';
      logs('error--> $mobileErrorText');
    }
  }

  @action
  void onTapMobileSubmit() {
    if (mobileValid == 1) {
      AppRouter.pushNamed(Routes.mobileOtpView);
    }
  }
}
