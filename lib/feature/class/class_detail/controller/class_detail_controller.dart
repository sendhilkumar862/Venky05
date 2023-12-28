
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../../product/utils/common_function.dart';


class ClassDetailController extends GetxController{
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  final KeyValueStorageService keyValueStorageService =
  KeyValueStorageService();


  @override
  @override
  void onInit() {
  selectedProfile.value =
  keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ??
  '';
}


  RxString selectedProfile = ''.obs;


  RxString selectedTimes = formatTime(DateTime.now()).obs;


  RxString selectedDate = formatTime(DateTime.now()).obs;

  RxBool isActive = false.obs;



  bool onTapSwitch() {
    isActive.value = !isActive.value;
    return isActive.value;
  }

}
