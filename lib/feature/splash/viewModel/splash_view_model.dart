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
  String? selectedCountry;
  String? selectedLanguage;
  String? selectedProfile;
  @override
  void init() {
    checkTheStatus().whenComplete(() async => setRoute());
  }

  Future<void> checkTheStatus() async {
    await KeyValueStorageBase.init();
    selectedCountry =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.country);

    selectedLanguage =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.language);

    selectedProfile =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.profile);
  }

  Future<void> setRoute() async {
    if (selectedCountry == null || selectedLanguage == null) {
      navigation(const LanguageView());
    } else if (selectedProfile == null) {
      navigation(const ProfileSelectionView(continueRegistration: true));
    } else {
      navigation(const OnboardingView(continueRegistration: true));
    }
  }

  Future<void> navigation(Widget page) async => Future<void>.delayed(
        const Duration(milliseconds: 5000),
        () async => AppRouter.push(page),
      );
}
