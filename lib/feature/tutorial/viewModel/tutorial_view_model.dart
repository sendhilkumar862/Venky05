import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../product/constants/app/app_utils.dart';
import '../../../product/utils/validators.dart';

part 'tutorial_view_model.g.dart';

class TutorialViewModel = _TutorialViewModelBase with _$TutorialViewModel;

abstract class _TutorialViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  @observable
  int selectedIndex = -1;

  @observable
  List profileItems = <String>['Teacher', 'Parent/Student'];


}
