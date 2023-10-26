import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'student_profile_view_model.g.dart';


class StudentProfileViewModel = _StudentProfileViewModelBase with _$StudentProfileViewModel;

abstract class _StudentProfileViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
