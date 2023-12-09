import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'manage_subscription_view_model.g.dart';

class ManageSubscriptionViewModel = _ManageSubscriptionViewModelBase
    with _$ManageSubscriptionViewModel;

abstract class _ManageSubscriptionViewModelBase extends BaseViewModel
    with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
