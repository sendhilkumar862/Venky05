import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../product/cache/locale_manager.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../tutorial/view/language_view.dart';

part 'tutorial_view_model.g.dart';

class TutorialViewModel = _TutorialViewModelBase with _$TutorialViewModel;

abstract class _TutorialViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    print('ented');
  }

  @observable
  String selectedItem = '';

  @observable
  int selectedIndex = -1;

  @observable
  TextEditingController mobileController = TextEditingController();

  @observable
  TextEditingController emailController = TextEditingController();

  @observable
  List profileItems = <String>['Teacher', 'Parent/Student'];

  @observable
  List<String> countries = [
    'Oman',
    'Bahrain',
    'Qatar',
    'Saudi Arabia',
    'UEA',
  ];

  void selectItem(String item) {
    runInAction(() {
      selectedItem = item;
    });
  }

  @observable
  List<String> countryLogo = [
    ImageConstants.oman,
    ImageConstants.bahrain,
    ImageConstants.qatar,
    ImageConstants.saudiArabia,
    ImageConstants.uae,
  ];

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
  List<String> passWordCriteria = [
    'Contain Minimum 8 Characters',
    'Contain Numbers',
    r'Contain Special characters (e.g., !, @, #, $)',
    'Contain Uppercase letters',
    'Contain Lowercase letters',
    'New and Retype Passwords should be matches',
  ];

  @observable
  List<bool> isPassWordCriteria = List.filled(6, false);

  @observable
  List<String> filteredCountries = [];

  @action
  void selectProfile(int index) {
    selectedIndex = index;
    LocaleManager.instance.setIntValue(LocaleManager.profile, index);
  }

  @action
  void selectCountry(int index) {
    selectedIndex = index;
  }

  @action
  void selectLanguage(int index) {
    selectedIndex = index;
  }

  @action
  void filterCountries(String query) {
    filteredCountries = countries
        .where((String country) =>
            country.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @observable
  bool isActive = false;

  @action
  void onTapTermAndCondition() {
    isActive = !isActive;
  }

  @observable
  String emailErrorText = '';

  @action
  validateEmail(String value) {
    if (value!.isEmpty) {
      emailErrorText = 'Please enter Email';
    } else if (Regexes.validateRegEx(
        emailController.text, Regexes.emailRegex)) {
      emailErrorText = 'Enter a valid email address (e.g., name@example.com)';
    } else {
      emailErrorText = '';
      print('error--> ${emailErrorText}');
    }
  }

  @observable
  String mobileErrorText = '';

  @action
  void validateMobile(String value) {
    if (value!.isEmpty) {
      emailErrorText = 'Please enter Email';
    } else if (8 > emailController.text.length) {
      emailErrorText = 'Kuwaiti number should be 8 digits';
    } else if (Regexes.validateRegEx(
        emailController.text, Regexes.contactRegex)) {
      emailErrorText = 'Kuwaiti number should be start with 4,5,6 and 9';
    } else {
      emailErrorText = '';
      print('error--> ${emailErrorText}');
    }
  }
}
