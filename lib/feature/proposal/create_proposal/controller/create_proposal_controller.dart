import 'package:get/get.dart';

import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/common_function.dart';

class CreateProposalController extends GetxController{
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  final KeyValueStorageService keyValueStorageService =
  KeyValueStorageService();


  RxString selectedProfile = ''.obs;


  RxString selectedTimes = formatTime(DateTime.now()).obs;


  RxString selectedDate = formatTime(DateTime.now()).obs;


  RxBool isActive = false.obs;



  @override
  void onInit() {
    super.onInit();
    selectedProfile.value =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ??
            '';
  }
}
