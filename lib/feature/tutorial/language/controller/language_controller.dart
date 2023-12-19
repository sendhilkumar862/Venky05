
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hessah/core/base_response.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../repository/language_repository.dart';
import '../model/country_model.dart';

class LanguageController extends GetxController {
  RxString error=''.obs;
  RxString loginStatus = ''.obs;
  List<Country> countries = <Country>[];
  List<Country> temp = <Country>[];
  Rxn<Country> selectedCountry = Rxn<Country>();
  RxString selectedItem = ''.obs;
  Rx<TextEditingController> countryController = TextEditingController().obs;
  RxList<String> countryLogo = <String>[].obs;
  RxInt languageIndex = 1.obs;
  RxList languages = [
    'English',
    'عربي',
  ].obs;
  RxList<String> languageIcon = [
    ImageConstants.usIconNew,
    ImageConstants.saudiArabiaNew,
  ].obs;

  final LanguageRepository _languageRepository = LanguageRepository();

  @override
  void onInit() {
    fetchData();
    KeyValueStorageBase.init();
    super.onInit();
  }

  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  final KeyValueStorageService keyValueStorageService =
      KeyValueStorageService();

  Future<void> fetchData() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse getProfileIDResponse = await _languageRepository.getCountryID();
    if (getProfileIDResponse.status?.type == 'success') {
      List data =getProfileIDResponse.data?.item as List;
      countries.clear();
      temp.clear();
      for (var element in data) {
        countries.add(Country.fromJson(element));
        temp.add(Country.fromJson(element));
      }
     } else {
      loginStatus.value=getProfileIDResponse.status?.type??'';
      error.value = getProfileIDResponse.status?.message ?? '';
    }
    EasyLoading.dismiss();
  }

  void selectLanguage(int index) {
    languageIndex.value = index;
  }

  void selectCountry(Country country) {
    selectedCountry.value = country;
    keyValueStorageBase.setCommon(
        KeyValueStorageService.countryCodeAndIDD, country.idd_code);
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
    keyValueStorageBase.setCommon(
        KeyValueStorageService.country, selectedCountry.value?.flag_url ?? '');
    keyValueStorageBase.setCommon(
        KeyValueStorageService.language, languageIndex == 0 ? 'en' : 'ar');
    AppRouter.pushNamed(Routes.profileSelectionView);
  }
}
