import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'create_class_view_model.g.dart';

class CreateClassViewModel = _CreateClassViewModelBase
    with _$CreateClassViewModel;

abstract class _CreateClassViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
