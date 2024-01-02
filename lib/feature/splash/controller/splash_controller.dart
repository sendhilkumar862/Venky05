import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/routes/route.dart';
import '../../../config/routes/routes.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../../../product/utils/validators.dart';
import '../../tutorial/language/view/language_view.dart';
import '../../tutorial/onboarding/view/onboading_view.dart';
import '../../tutorial/profileSet/view/profile_selection_view.dart';

class SplashController extends GetxController {
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  final KeyValueStorageService keyValueStorageService =
      KeyValueStorageService();
  String? selectedCountry;
  String? selectedLanguage;
  String? selectedProfile;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await KeyValueStorageBase.init();
    // await keyValueStorageBase.clearEncrypted();
    // await keyValueStorageBase.clearCommon();

    final String token = await keyValueStorageService.getAuthToken();
    if (token.isNotEmpty) {
      logs('Token--> $token');
      Future.delayed(const Duration(milliseconds: 5000), () {
        return Get.toNamed(Routes.HomeScreenRoute);
      });
    } else {
      checkTheStatus().whenComplete(() async => setRoute());
    }
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
    if (selectedCountry == null ||
        selectedLanguage == null ||
        selectedCountry!.isEmpty ||
        selectedLanguage!.isEmpty) {
      Get.toNamed(Routes.languageView);
    } else if (selectedProfile == null || selectedProfile!.isEmpty) {
      var  data = {
        'continueRegistration' : true,
      };
      Get.toNamed(Routes.onBoardingView,arguments: data);
    } else {
      var  data = {
        'continueRegistration' : true,
      };
      Get.toNamed(Routes.onBoardingView,arguments: data);
      // navigation(OnBoardingView(continueRegistration: true));
    }
  }

  // Future<void> navigation(Widget page) async => Future<void>.delayed(
  //       const Duration(milliseconds: 5000),
  //       () async => AppRouter.push(page),
  //     );
}
