import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../core/base_response.dart';
import '../view/setting_view.dart';
import '../../tutorial/language/model/country_model.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../../../product/utils/validators.dart';
import '../../../repository/setting_repository.dart';


class SettingController  extends GetxController{
  RxString error=''.obs;
  RxString loginStatus = ''.obs;
  RxString selectedProfile = ''.obs;
  RxString selectedCountryName = ''.obs;
  RxString selectedLanguage = ''.obs;
  RxInt countryIndex = 118.obs;
  RxString selectedItem = ''.obs;
  RxInt languageIndex = 1.obs;
  Rx<TextEditingController> countryController = TextEditingController().obs;
  RxList<String> languages = <String>[
    'عربي',
    'English',
  ].obs;
  RxList<String> languageIcon = <String>[
    ImageConstants.countryIcon,
    ImageConstants.usIcon,
  ].obs;

  // RxCountry? selectedCountry;


  Rxn<Country?> selectedCountry= Rxn<Country>();

  RxList<Country> countries = <Country>[].obs;

  RxList<Country>filteredCountries = <Country>[].obs;

  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  final KeyValueStorageService keyValueStorageService =
  KeyValueStorageService();
  final SettingRepository _settingRepository = SettingRepository();

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

  RxList<ProfileList> profileListData = <ProfileList>[
    ProfileList(text: 'Take Photo', icon: ImageConstants.camera),
    ProfileList(text: 'Add Image', icon: ImageConstants.pictureSquare),
    ProfileList(text: 'Add File', icon: ImageConstants.attach),
  ].obs;



  Future<void> getProfile() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    logs('entered Fetch country data');
    Dio dio = Dio();
    try {
      var response =
      await dio.get('http://167.99.93.83/api/v1/public/countries/idd');
      logs('Status code--> ${response.statusCode}');

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final List<dynamic> countriesJson = response.data['data']['items'];
        countries =
            countriesJson.map((json) => Country.fromJson(json)) as RxList<Country>;
      }
    } catch (error) {
      EasyLoading.dismiss();

      logs('Error: $error');
    }

    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse getProfileResponse = await _settingRepository.getProfile();
    if (getProfileResponse.status?.type == 'success') {
      // final List<dynamic> countriesJson = getProfileResponse.data?["data"]['items'];
      // countries =
      // countriesJson.map((json) => Country.fromJson(json)) as RxList;
      final KeyValueStorageService keyValueStorageService = KeyValueStorageService();

    } else {
      loginStatus.value=getProfileResponse.status?.type??'';
      error.value = getProfileResponse.status?.message ?? '';
    }
    EasyLoading.dismiss();
  }


  void selectLanguage(int index) {
    languageIndex = index.obs;

    if (languages[index] == 0) {
      keyValueStorageBase.setCommon(KeyValueStorageService.language, 'en');
    } else {
      keyValueStorageBase.setCommon(KeyValueStorageService.language, 'ar');
    }

    logs('selected lang-->$languageIndex');
  }

  void getProfileData() {
    selectedProfile.value =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ??
            ApplicationConstants.tutor;

    selectedCountryName.value =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.country) ??
            '';

    selectedLanguage.value = keyValueStorageBase.getCommon(
        String, KeyValueStorageService.language) ??
        '';
  }

}