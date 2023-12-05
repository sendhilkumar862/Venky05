import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase extends BaseViewModel with Store {
  @override
  Future<void> setContext(BuildContext context) async {
    viewModelContext = context;
  }

  @override
  void init() {}
}
