import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../config/routes/route.dart';
import '../../../core/base_response.dart';
import '../../../core/local_auth_services.dart';
import '../../../product/cache/key_value_storeage.dart';
import '../../../product/cache/local_manager.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/validators.dart';
import '../../home/controller/home_controller.dart';
import '../../tutorial/language/model/country_model.dart';
import '../repository/update_profile_photo_repository.dart';
import '../view/setting_view.dart';

class SettingController extends GetxController {
  String croppedFilePath = '';
  RxString error = ''.obs;
  RxString loginStatus = ''.obs;
  RxString selectedProfile = ''.obs;
  RxString selectedCountryName = ''.obs;
  RxString selectedLanguage = ''.obs;
  RxInt countryIndex = 118.obs;
  RxString selectedItem = ''.obs;
  RxInt languageIndex = 1.obs;
  RxString authenticated = ''.obs;
  Rx<TextEditingController> countryController = TextEditingController().obs;
  final UpdateProfilePhotoRepository _updateProfilePhotoRepository =
      UpdateProfilePhotoRepository();
  final HomeController _homeController = Get.put(HomeController());

  RxList<String> languages = <String>[
    'عربي',
    'English',
  ].obs;
  RxList<String> languageIcon = <String>[
    ImageConstants.countryIcon,
    ImageConstants.usIcon,
  ].obs;

  // RxCountry? selectedCountry;

  @override
  void onInit() {
    fetchLocalAuth();
    getProfileData();
    super.onInit();
  }

// ignore: always_declare_return_types

  Rxn<Country?> selectedCountry = Rxn<Country>();

  RxList<Country> countries = <Country>[].obs;

  RxList<Country> filteredCountries = <Country>[].obs;

  RxList<SettingHeading> studentSettingList = <SettingHeading>[
    SettingHeading(header: 'Personal Information', listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/profile.svg', title: 'Change Name'),
      SettingData(
          surfixImage: 'assets/icons/mobile.svg', title: 'Add Mobile Number'),
      SettingData(
          surfixImage: 'assets/icons/pin_location.svg',
          title: 'Manage Address'),
    ]),
    SettingHeading(header: 'Account Settings', listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/globe_pin.svg', title: 'Change Country'),
      SettingData(
          surfixImage: 'assets/icons/language_translate.svg',
          title: 'Language'),
    ]),
    SettingHeading(header: 'Support', listDetail: <SettingData>[
      SettingData(surfixImage: 'assets/icons/ring.svg', title: 'App Support'),
    ]),
    SettingHeading(header: 'Security', listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/lock.svg', title: 'Change Password'),
      SettingData(
          surfixImage: 'assets/icons/face_id.svg',
          title: 'Login With Biometric'),
      SettingData(
        surfixImage: 'assets/icons/log_out.svg',
        title: 'Logout',
      ),
    ]),
  ].obs;

  RxList<SettingHeading> tutorSettingList = <SettingHeading>[
    SettingHeading(header: 'Personal Information', listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/profile.svg', title: 'Change Name'),
      SettingData(
          surfixImage: 'assets/icons/mobile.svg', title: 'Add Mobile Number'),
      SettingData(
          surfixImage: 'assets/icons/pin_location.svg',
          title: 'Manage Address'),
    ]),
    SettingHeading(header: 'Account Settings', listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/medal.svg', title: 'Manage Subscription'),
      SettingData(
          surfixImage: 'assets/icons/calendar.svg',
          title: 'Manage Availability Time'),
      SettingData(
          surfixImage: 'assets/icons/globe_pin.svg', title: 'Change Country'),
      SettingData(
          surfixImage: 'assets/icons/language_translate.svg',
          title: 'Language'),
    ]),
    SettingHeading(header: 'Support', listDetail: <SettingData>[
      SettingData(surfixImage: 'assets/icons/ring.svg', title: 'App Support'),
    ]),
    SettingHeading(header: 'Security', listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/lock.svg', title: 'Change Password'),
      SettingData(
          surfixImage: 'assets/icons/face_id.svg',
          title: 'Login With Biometric'),
      SettingData(
        surfixImage: 'assets/icons/log_out.svg',
        title: 'Logout',
      ),
    ]),
  ].obs;

  Future<void> uploadProfilePhoto() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse uploadResponse =
        await _updateProfilePhotoRepository.updateProfilePhoto(croppedFilePath);
    if (uploadResponse.status?.type == 'success') {
      _homeController.fetchData();
    } else {
      AppUtils.showFlushBar(
        context: Routes.navigatorKey.currentContext!,
        message: uploadResponse.status?.message ?? 'Error occurred',
      );
    }
    EasyLoading.dismiss();
  }

  setLocalAuth() async {
    final bool authenticatedStatus = await LocalAuth.authenticate();
    if (authenticatedStatus) {
      final String authToken = LocaleManager.getAuthToken() ??'';
      LocaleManager.setValue(StorageKeys.authBiometric,authToken ??'');

      authenticated.value = authenticatedStatus.toString();
    }
  }

  removeLocalAuth() async {
    final bool authenticatedStatus = await LocalAuth.authenticate();
    if (authenticatedStatus) {
      LocaleManager.removeValue(StorageKeys.authBiometric);
      authenticated.value = '';
    }
  }

  fetchLocalAuth() async {
    authenticated.value =  LocaleManager.getValue(StorageKeys.authBiometric) ??'';
  }

  logout(BuildContext context) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
     LocaleManager.removeAuthToken();
    LocaleManager.removeCreatedClassToken();
    await Get.deleteAll();
    EasyLoading.dismiss();
    Get.offAllNamed(Routes.loginView);
  }

  void selectLanguage(int index) {
    languageIndex = index.obs;

    if (languages[index] == 0) {
      LocaleManager.setValue(StorageKeys.language, 'en');
    } else {
      LocaleManager.setValue(StorageKeys.language, 'ar');
    }

    logs('selected lang-->$languageIndex');
  }

  void getProfileData() {
    selectedProfile.value =
        LocaleManager.getValue( StorageKeys.profile) ??
            ApplicationConstants.tutor;

    selectedCountryName.value =
        LocaleManager.getValue( StorageKeys.country) ??
            '';

    selectedLanguage.value =  LocaleManager.getValue(
        StorageKeys.language) ??
        '';
  }
}
