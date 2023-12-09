import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../tutorial/language/model/country_model.dart';
import '../view/setting_view.dart';

part 'setting_view_model.g.dart';

class SettingViewModel = _SettingViewModelBase with _$SettingViewModel;

abstract class _SettingViewModelBase extends BaseViewModel with Store {
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  final KeyValueStorageService keyValueStorageService =
      KeyValueStorageService();

  //==============================================================================
  // ** List of Student setting view **
  //==============================================================================
  List<SettingHeading> studentSettingList = <SettingHeading>[
    SettingHeading(header: 'personalInformation'.tr(), listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/profile.svg', title: 'changeName'.tr()),
      SettingData(
          surfixImage: 'assets/icons/mobile.svg', title: 'addMobileNumber'.tr()),
      SettingData(
          surfixImage: 'assets/icons/pin_location.svg',
          title: 'manageAddress'.tr()),
    ]),
    SettingHeading(header: 'accountSettings'.tr(), listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/globe_pin.svg', title: 'changeCountry'.tr()),
      SettingData(
          surfixImage: 'assets/icons/language_translate.svg',
          title: 'language'.tr()),
    ]),
    SettingHeading(header: 'support'.tr(), listDetail: <SettingData>[
      SettingData(surfixImage: 'assets/icons/ring.svg', title: 'appSupport'.tr()),
    ]),
    SettingHeading(header: 'security'.tr(), listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/lock.svg', title: 'changePassword'.tr()),
      SettingData(
          surfixImage: 'assets/icons/face_id.svg',
          title: 'loginWithBiometric'.tr()),
      SettingData(
        surfixImage: 'assets/icons/log_out.svg',
        title: 'logOut'.tr(),
      ),
    ]),
  ];

  //==============================================================================
  // ** List of Tutor setting view **
  //==============================================================================
  List<SettingHeading> tutorSettingList = <SettingHeading>[
    SettingHeading(header: 'personalInformation'.tr(), listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/profile.svg', title: 'changeName'.tr()),
      SettingData(
          surfixImage: 'assets/icons/mobile.svg', title: 'addMobileNumber'.tr()),
      SettingData(
          surfixImage: 'assets/icons/pin_location.svg',
          title: 'manageAddress'.tr()),
    ]),
    SettingHeading(header: 'accountSettings'.tr(), listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/medal.svg', title: 'manageSubscription'.tr()),
      SettingData(
          surfixImage: 'assets/icons/calendar.svg',
          title: 'manageAvailabilityTime'.tr()),
      SettingData(
          surfixImage: 'assets/icons/globe_pin.svg', title: 'changeCountry'.tr()),
      SettingData(
          surfixImage: 'assets/icons/language_translate.svg',
          title: 'language'.tr()),
    ]),
    SettingHeading(header: 'support'.tr(), listDetail: <SettingData>[
      SettingData(surfixImage: 'assets/icons/ring.svg', title: 'appSupport'.tr()),
    ]),
    SettingHeading(header: 'security'.tr(), listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/lock.svg', title: 'changePassword'.tr()),
      SettingData(
          surfixImage: 'assets/icons/face_id.svg',
          title: 'loginWithBiometric'.tr()),
      SettingData(
        surfixImage: 'assets/icons/log_out.svg',
        title: 'logOut'.tr(),
      ),
    ]),
  ];

  //==============================================================================
  // ** Properties **
  //==============================================================================
  List<ProfileList> profileListData = <ProfileList>[
    ProfileList(text: 'Take Photo', icon: ImageConstants.camera),
    ProfileList(text: 'Add Image', icon: ImageConstants.pictureSquare),
    ProfileList(text: 'Add File', icon: ImageConstants.attach),
  ];

  @observable
  String selectedProfile = '';
  @observable
  String selectedCountryName = '';
  @observable
  String selectedLanguege = '';

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    getProfile();
    fetchData();
    KeyValueStorageBase.init();

    // KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
    // keyValueStorageBase.setCommon(
    //    KeyValueStorageService.countryCodeAndIDD, 'KW,+965');
  }

  @observable
  Country? selectedCountry;
  @observable
  List<Country> countries = [];

  @observable
  List<Country> filteredCountries = [];

  Future<void> fetchData() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    logs('entered Fetch country data');
    Dio dio = Dio();
    try {
      Response response =
          await dio.get('http://167.99.93.83/api/v1/public/countries/idd');
      logs('Status code--> ${response.statusCode}');

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final List<dynamic> countriesJson = response.data['data']['items'];
        countries =
            countriesJson.map((json) => Country.fromJson(json)).toList();
      }
    } catch (error) {
      EasyLoading.dismiss();

      logs('Error: $error');
    }
  }

  @observable
  int countryIndex = 118;

  @observable
  String selectedItem = '';

  @observable
  int languageIndex = 1;

  @observable
  TextEditingController countryController = TextEditingController();

  @action
  void selectItem(String item) {
    runInAction(() {
      selectedItem = item;
    });
  }

  @observable
  List<String> languages = <String>[
    'عربي',
    'English',
  ];

  @observable
  List<String> languageIcon = <String>[
    ImageConstants.countryIcon,
    ImageConstants.usIcon,
  ];

  @action
  void selectCountry(int index) {
    countryIndex = index;
    keyValueStorageBase.setCommon(
        KeyValueStorageService.country, countries[index].name);
    keyValueStorageBase.setCommon(KeyValueStorageService.countryCodeAndIDD,
        '${countries[index].code},${countries[index].idd_code}');
    logs('selected Country-->$countryIndex');
  }

  @action
  void selectLanguage(int index) {
    languageIndex = index;

    if (languages[index] == 0) {
      keyValueStorageBase.setCommon(KeyValueStorageService.language, 'en');
    } else {
      keyValueStorageBase.setCommon(KeyValueStorageService.language, 'ar');
    }

    logs('selected lang-->$languageIndex');
  }

  @action
  void filterCountries(String query, Function setState) {
    filteredCountries = countries
        .where((Country country) =>
            country.name?.toLowerCase().contains(query.toLowerCase()) ??
            false ||
                country.flag_url!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    logs('filteredCountries.toString()--> ${filteredCountries.toString()}');
    setState(() {});
  }

  @action
  void getProfile() {
    selectedProfile =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ??
            ApplicationConstants.tutor;

    selectedCountryName =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.country) ??
            '';

    selectedLanguege = keyValueStorageBase.getCommon(
            String, KeyValueStorageService.language) ??
        '';
  }
}
