import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'change_name_view_model.g.dart';

class ChangeNameViewModel = _ChangeNameViewModelBase with _$ChangeNameViewModel;

abstract class _ChangeNameViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
