import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../config/routes/app_router.dart';
import '../../tutorial/language/language_view.dart';
import '../view/splash_first.dart';
import '../view/splash_second.dart';

part 'splash_view_model.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {
    Future.delayed(
      const Duration(milliseconds: 3000),
      () {
        AppRouter.push(const SplashSecond());
      },
    );
  }
}
