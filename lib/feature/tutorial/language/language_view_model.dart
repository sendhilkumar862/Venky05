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
    // getCounties();
  }

  @observable
  List<Country> response = <Country>[];

  @observable
  int countryIndex = 0;

  @observable
  String selectedItem = '';

  @observable
  int languageIndex = 0;

  @observable
  TextEditingController countryController = TextEditingController();

  @observable
  List<String> countries = [];

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
  List<String> filteredCountries = [];

  //@action
  // Future<void> getCounties() async {
  //   final _apiService = ref.watch(apiServiceProvider);
  //
  //       BaseOptions(method: 'GET', baseUrl: 'http://167.99.93.83/api/v1');
  //   final ApiService apiService = ApiService(DioService(dioClient: dio));
  //   response = await apiService.getCollectionData(
  //       endpoint: '/public/countries',
  //       converter: Country.fromJson,
  //       requiresAuthToken: false);
  //   logs('Response --> ${response}');
  //   response.forEach((Country element) {
  //     countries.add(element.name);
  //     countryLogo.add(element.flag_url);
  //   });
  // }

  @action
  void selectCountry(int index) {
    countryIndex = index;
    LocaleManager.instance
        .setStringValue(LocaleManager.country, countries[index]);
    logs('selected Country-->$countryIndex');
  }

  @action
  void selectLanguage(int index) {
    languageIndex = index;
    LocaleManager.instance
        .setStringValue(LocaleManager.country, languages[index]);
    logs('selected lang-->$languageIndex');
  }

  @action
  void filterCountries(String query, Function setState) {
    filteredCountries = countries
        .where((String country) =>
            country.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {});
  }
}
