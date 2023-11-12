import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../tutorial/view/language_view.dart';
import '../view/splash_first.dart';

part 'splash_second_view_model.g.dart';

class SplashSecondViewModel = _SplashSecondViewModelBase with _$SplashSecondViewModel;

abstract class _SplashSecondViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        AppRouter.push(const LanguageView());
      },
    );
  }
}
