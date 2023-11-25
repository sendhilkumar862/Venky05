import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';

part 'notification_view_model.g.dart';

class NotificationViewModel = _NotificationViewModelBase
    with _$NotificationViewModel;

abstract class _NotificationViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
