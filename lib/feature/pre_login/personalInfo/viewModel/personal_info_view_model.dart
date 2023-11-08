import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'personal_info_view_model.g.dart';

class PersonalInfoViewModel = _PersonalInfoViewModelBase
    with _$PersonalInfoViewModel;

abstract class _PersonalInfoViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  @observable
  String selectedItem = 'Kuwet';

  @observable
  String selectedLanguage = 'English';

  @observable
  List<String> countries = [
    'Oman',
    'Bahrain',
    'Qatar',
    'Saudi Arabia',
    'UEA',
  ];

  @observable
  List<String> languages = [
    'English',
    'عربي',
  ];

  void selectLanguage(String item) {
    runInAction(() {
      selectedLanguage = item;
    });
  }

  void selectItem(String item) {
    runInAction(() {
      selectedItem = item;
    });
  }
}
