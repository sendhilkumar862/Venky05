import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'class_detail_view_model.g.dart';

class ClassDetailViewModel = _ClassDetailViewModelBase
    with _$ClassDetailViewModel;

abstract class _ClassDetailViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
