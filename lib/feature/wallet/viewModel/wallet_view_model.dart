import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../view/wallet_view.dart';

part 'wallet_view_model.g.dart';

class WalletViewModel = _WalletViewModelBase with _$WalletViewModel;

abstract class _WalletViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
  @observable
  bool isActive = false;

  @observable
  TextEditingController withdrawController = TextEditingController();

  @observable
  TextEditingController accountNumberController = TextEditingController();

  @observable
  TextEditingController nameController = TextEditingController();

  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @observable
  String amountError = '';

  @observable
  String accountError = '';

  @observable
  String nameError = '';

  @observable
  int bankBalance = 100;

  @observable
  List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 'Jan', y: 0.541),
    ChartSampleData(x: 'Feb', y: 0.818),
    ChartSampleData(x: 'March', y: 1.51),
    ChartSampleData(x: 'April', y: 0),
    ChartSampleData(x: 'May', y: 0),
    ChartSampleData(x: 'June', y: 0),
  ];

  @action
  bool onTapSwitch() {
    isActive = !isActive;
    return isActive;
  }

  @action
  String? withdrawAmountValidation(String value) {
    final int? amount = int.tryParse(value);
    if (value!.isEmpty) {
      return 'Please enter an amount';
    } else if (amount == null || amount <= bankBalance) {
      amountError = 'valid';
      return 'Enter an amount within your balance limit';
    } else {
      amountError = 'error';
    }
  }

  @action
  String? accountNumberValidation(String value) {
    if (value!.isEmpty) {
      return 'Please enter account number';
    } else if (value.length < 30) {
      accountError = 'error';
      return 'Minimum IBAN number should be 30 digits';
    } else if (false) {
      accountError = 'error';
      return 'You have to enter local bank account number';
    } else {
      accountError = 'valid';
    }
  }

  @action
  String? nameValidation(String value) {
    if (value!.isEmpty) {
      nameError = 'error';

      return 'Please enter nickname';
    }  else {
      nameError = 'valid';
    }
  }
}
