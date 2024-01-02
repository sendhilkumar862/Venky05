
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../product/cache/key_value_storeage.dart';

import '../../../../product/cache/local_manager.dart';
import '../../../../product/utils/common_function.dart';


class ClassDetailController extends GetxController{
  @override
  @override
  void onInit() {
  selectedProfile.value =
      LocaleManager.getValue(StorageKeys.profile) ??
  '';
}

  RxInt? selectedIndex =200.obs;
  RxString selectedProfile = ''.obs;


  RxString selectedTimes = formatTime(DateTime.now()).obs;


  RxString selectedDate = formatTime(DateTime.now()).obs;

  RxBool isActive = false.obs;



  bool onTapSwitch() {
    isActive.value = !isActive.value;
    return isActive.value;
  }

}
