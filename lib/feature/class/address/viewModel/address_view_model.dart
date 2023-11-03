import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'address_view_model.g.dart';

class AddressViewModel = _AddressViewModelBase with _$AddressViewModel;

abstract class _AddressViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
