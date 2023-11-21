import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../model/country_model.dart';

part 'language_view_model.g.dart';

class LanguageViewModel = _LanguageViewModelBase with _$LanguageViewModel;

abstract class _LanguageViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    fetchData();
    KeyValueStorageBase.init();
  }

  @observable
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();

  @observable
  List<Country> countries = <Country>[];

  @observable
  List<Country> filteredCountries = <Country>[];

  Future<void> fetchData() async {
    final Dio dio = Dio();
    try {
      final Response response =
          await dio.get('http://167.99.93.83/api/v1/public/countries');

      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        final List<dynamic> countriesJson = response.data['data']['items'];
        countries =
            countriesJson.map((json) => Country.fromJson(json)).toList();
      } else {
        logs('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      logs('Error: $error');
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
  List<String> languages = <String>[
    'English',
    'عربي',
  ];

  @observable
  List<String> languageIcon = <String>[
    ImageConstants.usIconNew,
    ImageConstants.saudiArabiaNew,
  ];

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
                country.flag_url!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    logs('filteredCountries.toString()--> $filteredCountries');
    setState(() {});
  }
}
