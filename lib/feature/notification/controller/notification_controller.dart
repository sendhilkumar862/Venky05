import 'package:get/get.dart';

import '../../../product/constants/image/image_constants.dart';
import '../view/notification.dart';

class NotificationController extends GetxController{

  RxList<NotificationData> notificationDataList = <NotificationData>[
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
  ].obs;

  RxList<String> shortByList = <String>[
    'Date',
    'New to Old',
    'Old to New',
  ].obs;

  RxList<String> filterByList = <String>[
    'Status',
    'Read',
    'Unread',
  ].obs;


  void filterByValue(List<String> value) {
    shortByList.value = value;
  }


  void setSchoolValue(List<String> value) {
    filterByList.value = value;
  }
}
