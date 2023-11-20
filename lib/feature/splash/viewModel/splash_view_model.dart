import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../../tutorial/language/language_view.dart';
import '../../tutorial/onboarding/onboading_view.dart';
import '../../tutorial/view/profile_selection_view.dart';
import '../view/splash_first.dart';
import '../view/splash_second.dart';

part 'splash_view_model.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  @override
  void init() {
    log('Splash country selected${keyValueStorageBase.getCommon(KeyValueStorageService.country)}');
    log('Splash language selected${keyValueStorageBase.getCommon(KeyValueStorageService.language)}');
    if (keyValueStorageBase.getCommon(KeyValueStorageService.country) == null ||
        keyValueStorageBase.getCommon(KeyValueStorageService.language) ==
            null) {
      Future.delayed(
        const Duration(milliseconds: 5000),
        () => AppRouter.push(const LanguageView()),
      );
    } else if (keyValueStorageBase.getCommon(KeyValueStorageService.profile) ==
        null) {
      Future.delayed(
        const Duration(milliseconds: 5000),
        () => AppRouter.push(const ProfileSelectionView()),
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 5000),
        () => AppRouter.push(const OnboardingView()),
      );
    }
  }
}
