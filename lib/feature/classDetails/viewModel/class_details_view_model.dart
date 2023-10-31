import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';


part 'class_details_view_model.g.dart';

class ClassDetailsViewModel = _ClassDetailsViewModelBase with _$ClassDetailsViewModel;

abstract class _ClassDetailsViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
