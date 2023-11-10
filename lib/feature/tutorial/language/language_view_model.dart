import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hessah/feature/tutorial/language/language_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../product/cache/locale_manager.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/network/all_providers.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../../../product/network/networking/api_endpoint.dart';
import '../../../product/network/networking/api_service.dart';
import '../../../product/network/networking/dio_service.dart';
import '../../../product/network/networking/interceptors/refresh_token_interceptor.dart';
import '../../../product/utils/validators.dart';
import '../../tutorial/language/language_view.dart';
import 'country_model.dart';

part 'language_view_model.g.dart';

class LanguageViewModel = _LanguageViewModelBase with _$LanguageViewModel;

abstract class _LanguageViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    //getCounties();
    fetchData();
    KeyValueStorageBase.init();
  }

  @observable
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();

  @observable
  List<Country> countries = [];

  void fetchData() async {
    Dio dio = Dio();
    try {
      Response response =
          await dio.get('http://167.99.93.83/api/v1/public/countries');

      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> countriesJson = response.data['data']['items'];
        countries =
            countriesJson.map((json) => Country.fromJson(json)).toList();
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      // Handle the error
    }
  }

  @observable
  int countryIndex = 0;

  @observable
  String selectedItem = '';

  @observable
  int languageIndex = 0;

  @observable
  TextEditingController countryController = TextEditingController();

  @action
  void selectItem(String item) {
    runInAction(() {
      selectedItem = item;
    });
  }

  @observable
  List<String> countryLogo = [];

  @observable
  List<String> languages = [
    'English',
    'عربي',
  ];

  @observable
  List<String> languageIcon = [
    ImageConstants.usIcon,
    ImageConstants.saudiArabia,
  ];

  @observable
  List<Country> filteredCountries = [];



  @action
  void selectCountry(int index) {
    countryIndex = index;
    keyValueStorageBase.setCommon(
        KeyValueStorageService.country, countries[index].name);
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
                country.flag_url!.toLowerCase().contains(query.toLowerCase()) ??
            false)
        .toList();
    setState(() {});
  }
}
