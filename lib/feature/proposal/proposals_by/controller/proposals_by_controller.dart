import 'package:get/get.dart';

import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../view/proposals_by.dart';

class ProposalsByController extends GetxController{
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  final KeyValueStorageService keyValueStorageService =
  KeyValueStorageService();


  RxString selectedProfile = ''.obs;


  RxBool isActive = false.obs;

  List<Header> dataList = [
    Header(heading: 'Original Class Details', headingData: [
      HeaderData(icon: 'assets/icons/date_icon.png', title: '12/12 12:30pm'),
      HeaderData(icon: 'assets/icons/date_icon.png', title: '12/12 12:30pm'),
      HeaderData(icon: 'assets/icons/timer_icon.png', title: '1h 30m'),
      HeaderData(icon: 'assets/icons/timer_icon.png', title: '1h 30m'),
      HeaderData(
          icon: 'assets/icons/read_book_icon.png',
          title: '5.000 KWD / Session'),
    ]),
    Header(heading: 'Proposal Details', headingData: [
      HeaderData(icon: 'assets/icons/date_icon.png', title: '12/12 12:30pm'),
      HeaderData(icon: 'assets/icons/date_icon.png', title: '12/12 12:30pm'),
      HeaderData(icon: 'assets/icons/timer_icon.png', title: '1h 30m'),
      HeaderData(icon: 'assets/icons/timer_icon.png', title: '1h 30m'),
      HeaderData(
          icon: 'assets/icons/read_book_icon.png',
          title: '5.000 KWD / Session'),
    ]),
  ];



  @override
  void onInit() {
    super.onInit();
    selectedProfile.value =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ??
            '';
  }
}
