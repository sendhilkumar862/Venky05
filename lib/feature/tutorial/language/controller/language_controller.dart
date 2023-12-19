import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../product/base/model/base_model.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../model/country_model.dart';

class LanguageController extends GetxController {
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
    logs('entered Fetch country data');
    final Dio dio = Dio();
    try {
      var response =
          await dio.get('http://167.99.93.83/api/v1/public/countries/idd');
      logs('Status code--> ${response.statusCode}');

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final BaseResponse<Country> baseResponse =
            BaseResponse<Country>.fromJson(
                response.data as Map<String, dynamic>, Country.fromJson);
        countries = baseResponse.data.items ?? <Country>[];
        temp = baseResponse.data.items ?? <Country>[];
      }
    } catch (error) {
      EasyLoading.dismiss();
      logs('Error: $error');
    }
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
