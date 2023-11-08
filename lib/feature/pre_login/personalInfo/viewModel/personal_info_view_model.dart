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
  String selectedItem = '';

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
}
