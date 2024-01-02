import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../core/base_response.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../home/controller/home_controller.dart';
import '../model/country_model.dart';
import '../repository/country_update_repository.dart';
import '../repository/language_repository.dart';

class LanguageController extends GetxController {
  RxString error = ''.obs;
  RxString loginStatus = ''.obs;
  List<Country> countries = <Country>[];
  List<Country> temp = <Country>[];
  Rxn<Country> selectedCountry = Rxn<Country>();
  RxString selectedItem = ''.obs;
  Rx<TextEditingController> countryController = TextEditingController().obs;
  RxList<String> countryLogo = <String>[].obs;
  RxInt languageIndex = 0.obs;
  final HomeController _homeController = Get.put(HomeController());
  RxList languages = <String>[
    'English',
    'عربي',
  ].obs;
  RxList<String> languageIcon = [
    ImageConstants.ukIcon,
    ImageConstants.kuwaitFlag,
  ].obs;

  final LanguageRepository _languageRepository = LanguageRepository();
  final CountryUpdateRepository _countryUpdateRepository =
      CountryUpdateRepository();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse getProfileIDResponse =
        await _languageRepository.getCountryID();
    if (getProfileIDResponse.status?.type == 'success') {
      List data = getProfileIDResponse.data?.item as List;
      countries.clear();
      temp.clear();
      for (var element in data) {
        countries.add(Country.fromJson(element));
        temp.add(Country.fromJson(element));
      }
      selectedCountry.value = countries[0];
      if (_homeController.homeData.value?.country != null) {
        for (var element in countries) {
          if (element.name == _homeController.homeData.value?.country) {
            selectedCountry.value = element;
          }
        }
      }
    } else {
      loginStatus.value = getProfileIDResponse.status?.type ?? '';
      error.value = getProfileIDResponse.status?.message ?? '';
    }
    EasyLoading.dismiss();
  }

  void selectLanguage(int index) {
    languageIndex.value = index;
  }

  Future<void> selectCountry(Country country) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    selectedCountry.value = country;
    LocaleManager.setValue(
        StorageKeys.countryCodeAndIDD, country.idd_code);
    final String token =  LocaleManager.getAuthToken();
    if (token != '') {
      await _countryUpdateRepository.updateCountry(country.name ?? '');
      _homeController.fetchData();
    }
    EasyLoading.dismiss();
  }

  void filterCountries(String query, Function setState) {
    countries = countries
        .where((Country country) =>
            country.name?.toLowerCase().contains(query.toLowerCase()) ??
            false ||
                country.flag_url!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (countryController.value.text.isEmpty) {
      countries = temp;
    }
    setState(() {});
  }

  void onPressedContinue() {
    LocaleManager.setValue(
        StorageKeys.country, selectedCountry.value?.flag_url ?? '');
    LocaleManager.setValue(
        StorageKeys.countryName, selectedCountry.value?.name ?? '');
    LocaleManager.setValue(
        StorageKeys.language, languageIndex == 0 ? 'en' : 'ar');
    AppRouter.pushNamed(Routes.profileSelectionView);
  }
}
