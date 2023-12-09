import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../../product/utils/validators.dart';

part 'add_bank_view_model.g.dart';

class AddBankViewModel = _AddBankViewModelBase with _$AddBankViewModel;

abstract class _AddBankViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  Future<void> init() async {}

  @observable
  TextEditingController accountController = TextEditingController();

  @observable
  TextEditingController nameController = TextEditingController();


  @observable
  String accountError = '';

  @observable
  String nameError = '';

  @observable
  int accountValid = -1;

  @observable
  int nameValid = -1;

  @observable
  bool isActive = false;

  @action
  void onTapSwitch() {
    isActive  = !isActive;
  }

  @action
  void validateAccount(String value) {
    if (value.isEmpty) {
      accountValid = 0;
      accountError = 'Please enter account number';
    } else if (value.length < 30) {
      accountValid = 0;
      accountError = 'Minimum IBAN number should be 30 digits';
    } else {
      accountValid = 1;
      accountError = '';
      logs('error--> $accountValid');
    }
  }

  @action
  void validateName(String value) {
    if (value.isEmpty) {
      nameValid = 0;
      nameError = 'Please enter nickname';
    } else {
      nameValid = 1;
      nameError = '';
      logs('error--> $accountValid');
    }
  }
}
