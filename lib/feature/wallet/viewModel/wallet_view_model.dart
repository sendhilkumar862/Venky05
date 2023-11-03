import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'wallet_view_model.g.dart';

class WalletViewModel = _WalletViewModelBase with _$WalletViewModel;

abstract class _WalletViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

}
