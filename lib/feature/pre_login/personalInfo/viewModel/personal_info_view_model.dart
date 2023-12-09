import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';

import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/base/model/base_model.dart';
import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/validators.dart';
import '../../../tutorial/language/model/country_model.dart';

part 'personal_info_view_model.g.dart';

class PersonalInfoViewModel = _PersonalInfoViewModelBase with _$PersonalInfoViewModel;

abstract class _PersonalInfoViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    fetchData();
  }

  @observable
  String selectedItem = '';

  @observable
  Country? selectedCountry;

  @observable
  TextEditingController countryController = TextEditingController();

  void selectItem(String item) {
    runInAction(() {
      selectedItem = item;
    });
  }

  @action
  void selectCountry(Country country) {
    selectedCountry = country;
    logs(selectedCountry.toString());
  }

  @observable
  List<Country> countries = <Country>[];

  @observable
  List<Country> temp = <Country>[];

  @observable
  List isLanguageSelected = List.filled(2, false);

  @observable
  List languageList = [];

  @observable
  TextEditingController languageController = TextEditingController();

  @observable
  List<String> languages = <String>[
    'English',
    'عربي',
  ];

  @action
  void selectLanguage(int index,) {
    isLanguageSelected[index] = !isLanguageSelected[index];

    if (isLanguageSelected[index]) {
      languageList.add(languages[index]);
    } else {
      languageList.remove(languages[index]);
    }

    languageController.text = languageList.toString().replaceAll('[', '').replaceAll(']', '');
    logs('languageController.text--> ${languageController.text}');
  }

  @observable
  List<String> languageIcon = <String>[
    ImageConstants.usIconNew,
    ImageConstants.saudiArabiaNew,
  ];

  Future<void> fetchData() async {
    showLoading();
    logs('entered Fetch country data');
    final Dio dio = Dio();
    try {
      Response response = await dio.get('http://167.99.93.83/api/v1/public/countries/idd');

      logs('Status code--> ${response.statusCode}');

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final BaseResponse<Country> baseResponse =
            BaseResponse<Country>.fromJson(response.data as Map<String, dynamic>, Country.fromJson);
        countries = baseResponse.data.items ?? <Country>[];
        temp = baseResponse.data.items ?? <Country>[];
      }
    } catch (error) {
      EasyLoading.dismiss();
      logs('Error: $error');
    }
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
}
