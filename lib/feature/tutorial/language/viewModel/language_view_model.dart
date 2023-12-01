import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:mobx/mobx.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/validators.dart';
import '../../profileSet/view/profile_selection_view.dart';
import '../model/country_model.dart';

part 'language_view_model.g.dart';

class LanguageViewModel = _LanguageViewModelBase with _$LanguageViewModel;

abstract class _LanguageViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    fetchData();
    KeyValueStorageBase.init();
  }

  @observable
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();

  @observable
  List<Country> countries = <Country>[];

  @observable
  List<Country> temp = <Country>[];

  Future<void> fetchData() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    logs('entered Fetch country data');
    Dio dio = Dio();
    try {
      Response response = await dio.get('http://167.99.93.83/api/v1/public/countries/idd');
      logs('Status code--> ${response.statusCode}');

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final List<dynamic> countriesJson = response.data['data']['items'];
        countries = countriesJson.map((json) => Country.fromJson(json)).toList();
        temp = countriesJson.map((json) => Country.fromJson(json)).toList();
      }
    } catch (error) {
      EasyLoading.dismiss();

      logs('Error: $error');
    }
  }

  @observable
  Country? selectedCountry;

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
  List<String> countryLogo = <String>[];

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
  void selectCountry(Country country) {
    selectedCountry = country;
  }

  @action
  void selectLanguage(int index) {
    languageIndex = index;
  }

  @action
  void filterCountries(String query, Function setState) {
    countries = countries
        .where((Country country) =>
            country.name?.toLowerCase().contains(query.toLowerCase()) ??
            false || country.flag_url!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (countryController.text.isEmpty) {
      countries = temp;
    }
    setState(() {});
  }

  @action
  void onPressedContinue() {
    keyValueStorageBase.setCommon(KeyValueStorageService.country, selectedCountry?.name ?? '');
    keyValueStorageBase.setCommon(KeyValueStorageService.language, languageIndex == 0 ? 'en' : 'ar');
    AppRouter.push(const ProfileSelectionView());
  }
}
