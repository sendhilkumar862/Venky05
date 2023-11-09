import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pdf/widgets.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../product/cache/locale_manager.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/validators.dart';
import '../../tutorial/view/language_view.dart';

part 'tutorial_view_model.g.dart';

class TutorialViewModel = _TutorialViewModelBase with _$TutorialViewModel;

abstract class _TutorialViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  @observable
  String selectedItem = '';

  @observable
  int selectedIndex = -1;

  @observable
  int countryIndex = 0;

  @observable
  int languageIndex = 0;

  @observable
  List profileItems = <String>['Teacher', 'Parent/Student'];

  @observable
  TextEditingController countryController = TextEditingController();

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
  List<String> filteredCountries = [];

  @action
  void selectProfile(int index) {
    selectedIndex = index;
    LocaleManager.instance.setIntValue(LocaleManager.profile, index);
  }

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
    logs('filtered Country List --> $filteredCountries');
  }

  @observable
  bool isActive = false;

  @action
  void onTapTermAndCondition() {
    isActive = !isActive;
  }

  @observable
  bool isActiveSwitch = false;

  @action
  void onTapSwitch() {
    isActiveSwitch = !isActiveSwitch;
    logs('isActiveSwitch-->${isActiveSwitch}');
  }

  //======== userInfo ========//

  @observable
  TextEditingController firstNameController = TextEditingController();

  @observable
  TextEditingController lastNameController = TextEditingController();

  @observable
  String firstNameErrorText = '';

  @observable
  String lastNameErrorText = '';

  @observable
  int firstNameValid = 2;

  @observable
  int lastNameValid = 2;

  @action
  void validateFirstName(String value) {
    if (value!.isEmpty) {
      firstNameValid = 0;
      firstNameErrorText = 'pleaseEnterFirstName'.tr();
    } else if (Regexes.validateRegEx(
        firstNameController.text, Regexes.nameRegex)) {
      firstNameValid = 0;

      firstNameErrorText = 'enterValidName'.tr();
    } else {
      firstNameValid = 1;
      firstNameErrorText = '';
      logs('error--> $firstNameErrorText');
    }
  }

  @action
  void validateLastName(String value) {
    if (value!.isEmpty) {
      lastNameValid = 0;
      lastNameErrorText = 'Please enter Last Name';
    } else if (Regexes.validateRegEx(
        lastNameController.text, Regexes.nameRegex)) {
      lastNameValid = 0;

      lastNameErrorText = 'enterValidLastname';
    } else {
      lastNameValid = 1;
      lastNameErrorText = '';
      logs('error--> $lastNameErrorText');
    }
  }

  @action
  void onTapSubmitUserInfo() {
    if (firstNameValid == 1 && lastNameValid == 1) {
      AppRouter.pushNamed(Routes.passwordView);
    }
  }

  @action
  bool isDisableUserInfoSubmit() {
    if (firstNameValid == 1 && lastNameValid == 1) {
      return false;
    } else {
      return true;
    }
  }

  //========password========//

  @observable
  List<String> passWordCriteria = [
    'minCharacters'.tr(),
    'containNumbers'.tr(),
    'containSpecialChars'.tr(),
    'containUppercase'.tr(),
    'containLowercase'.tr(),
    'matchPasswords'.tr(),
  ];

  @observable
  List<bool> isPassWordCriteria = List.filled(6, false);

  @observable
  TextEditingController passwordController = TextEditingController();

  @observable
  TextEditingController retypePasswordController = TextEditingController();

  @action
  void validatePassword(String value) {
    if (value.length >= 8) {
      isPassWordCriteria[0] = true;
    } else {
      isPassWordCriteria[0] = false;
    }

    if (Regexes.validate(value, Regexes.digitRegExp)) {
      isPassWordCriteria[1] = true;
    } else {
      isPassWordCriteria[1] = false;
    }

    if (Regexes.validate(value, Regexes.specialCharRegExp)) {
      isPassWordCriteria[2] = true;
    } else {
      isPassWordCriteria[2] = false;
    }

    if (Regexes.validate(value, Regexes.uppercaseRegExp)) {
      isPassWordCriteria[3] = true;
    } else {
      isPassWordCriteria[3] = false;
    }

    if (Regexes.validate(value, Regexes.lowercaseRegExp)) {
      isPassWordCriteria[4] = true;
    } else {
      isPassWordCriteria[4] = false;
    }

    logs(isPassWordCriteria.toString());
  }

  @action
  void validateRetypePassword(String value) {
    if (value == passwordController.text) {
      isPassWordCriteria[5] = false;
    } else {
      isPassWordCriteria[5] = false;
    }
  }

  @action
  void onTapSubmitPassword() {
    if (isPassWordCriteria.contains(false) && isActive) {
      AppRouter.pushNamed(Routes.homeViews);
    }
  }
}
