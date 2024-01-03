
import 'package:get/get.dart';
import '../../../config/routes/route.dart';
import '../../../product/cache/key_value_storeage.dart';
import '../../../product/cache/local_manager.dart';
import '../../../product/utils/validators.dart';

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
        return Get.toNamed(Routes.HomeScreenRoute);
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
    }
  }

}
