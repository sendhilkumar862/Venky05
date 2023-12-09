import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'app_support_view_model.g.dart';

class AppSupportViewModel = _AppSupportViewModelBase with _$AppSupportViewModel;

abstract class _AppSupportViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
