import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'wallets_view_model.g.dart';

class WalletsViewModel = _WalletsViewModelBase with _$WalletsViewModel;

abstract class _WalletsViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
  @observable
  bool isActive = false;

  @observable
  TextEditingController withdrawController = TextEditingController();


  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @observable
  String amountError = '';
  
  @observable
  int bankBalance = 100;



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

}
