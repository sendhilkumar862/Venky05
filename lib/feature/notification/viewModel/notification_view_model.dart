import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../product/base/model/base_view_model.dart';
import '../../../product/constants/image/image_constants.dart';
import '../view/notification.dart';

part 'notification_view_model.g.dart';

class NotificationViewModel = _NotificationViewModelBase
    with _$NotificationViewModel;

abstract class _NotificationViewModelBase extends BaseViewModel with Store {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @observable
  List<NotificationData> notificationDataList = <NotificationData>[
    NotificationData(
        id: "jhg",
        icon: ImageConstants.read,
        title: 'Class Booked',
        description: 'Class #1234567890 booked and waiting to be accepted',
        time: '12:34 AM'),
    NotificationData(
        id: 'gfdg',
        icon: ImageConstants.wallet,
        title: 'Top Up Wallet',
        description: 'Wallet Top Upped 10 KWD',
        time: '12:34 AM'),
  ];
  @observable
  List<String> shortByList = <String>[
    'Date',
    'New to Old',
    'Old to New',
  ];
  @observable
  List<String> filterByList = <String>[
    'Status',
    'Read',
    'Unread',
  ];

  @action
  void filterByValue(List<String> value) {
    shortByList = value;
  }

  @action
  void setSchoolValue(List<String> value) {
    filterByList = value;
  }

  @override
  void init() {}
}
