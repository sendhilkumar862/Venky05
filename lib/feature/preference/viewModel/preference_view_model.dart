import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'preference_view_model.g.dart';


class PreferenceViewModel = _PreferenceViewModelBase with _$PreferenceViewModel;

abstract class _PreferenceViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
