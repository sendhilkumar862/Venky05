import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../product/cache/key_value_storeage.dart';
import '../../../product/cache/local_manager.dart';
import '../../../product/utils/validators.dart';
import '../../tutorial/language/view/language_view.dart';
import '../../tutorial/onboarding/view/onboading_view.dart';
import '../../tutorial/profileSet/view/profile_selection_view.dart';

class SplashController extends GetxController {
  String? selectedCountry;
  String? selectedLanguage;
  String? selectedProfile;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    // await keyValueStorageBase.clearEncrypted();
    // await keyValueStorageBase.clearCommon();

    final String token = LocaleManager.getAuthToken();
    if (token.isNotEmpty) {
      logs('Token--> $token');
      Future.delayed(const Duration(milliseconds: 5000), () {
        return AppRouter.pushNamed(Routes.HomeScreenRoute);
      });
    } else {
      checkTheStatus().whenComplete(() async => setRoute());
    }
  }

  Future<void> checkTheStatus() async {
    selectedCountry =  LocaleManager.getValue( StorageKeys.country) ??'';

    selectedLanguage =
        LocaleManager.getValue( StorageKeys.language) ??'';

    selectedProfile =
        LocaleManager.getValue( StorageKeys.profile) ??'';
  }

  Future<void> setRoute() async {
    if (selectedCountry == null ||
        selectedLanguage == null ||
        selectedCountry!.isEmpty ||
        selectedLanguage!.isEmpty) {
      navigation(LanguageView());
    } else if (selectedProfile == null || selectedProfile!.isEmpty) {
      navigation(ProfileSelectionView(continueRegistration: true));
    } else {
      navigation(OnboardingView(continueRegistration: true));
    }
  }

  Future<void> navigation(Widget page) async => Future<void>.delayed(
        const Duration(milliseconds: 5000),
        () async => AppRouter.push(page),
      );
}
