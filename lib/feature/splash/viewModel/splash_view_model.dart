import 'package:flutter/material.dart';
import 'package:hessah/custom/sheet/show_bottom_sheet.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../../../product/utils/validators.dart';
import '../../preference/view/preference_view.dart';
import '../../tutorial/language/view/language_view.dart';
import '../../tutorial/onboarding/view/onboading_view.dart';
import '../../tutorial/profileSet/view/profile_selection_view.dart';

part 'splash_view_model.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  final KeyValueStorageService keyValueStorageService =
      KeyValueStorageService();

  String? selectedCountry;
  String? selectedLanguage;
  String? selectedProfile;

  @override
  Future<void> init() async {
    await KeyValueStorageBase.init();

    final String token = await keyValueStorageService.getAuthToken();
    if (token.isNotEmpty) {
      logs('Token--> $token');
      Future.delayed(const Duration(milliseconds: 5000), () {
        selectedProfile = keyValueStorageBase.getCommon(
            String, KeyValueStorageService.profile);
        final bool getPreference = keyValueStorageBase.getCommon(
                bool, KeyValueStorageService.setPreference) ??
            false;
        if (selectedProfile == ApplicationConstants.student && !getPreference) {
          showCommonBottomSheet(
              context: AppRouter.navigatorKey.currentContext!,
              commonWidget: const PreferenceView());
        } else {
          return AppRouter.pushNamed(Routes.HomeScreenRoute);
        }
      });
    } else {
      checkTheStatus().whenComplete(() async => setRoute());
    }
  }

  Future<void> checkTheStatus() async {
    final KeyValueStorageService keyValueStorageService =
        KeyValueStorageService();
    final String token = keyValueStorageService.getAuthToken().toString();
    // if (token != null) {
    //   logs('Token--> $token');
    //   AppRouter.pushNamed(Routes.HomeScreenRoute);
    // }
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
