import 'package:get/get.dart';
import '../../../../product/cache/key_value_storeage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../../../product/utils/common_function.dart';

class CreateProposalController extends GetxController{


  RxString selectedProfile = ''.obs;


  RxString selectedTimes = formatTime(DateTime.now()).obs;


  RxString selectedDate = formatTime(DateTime.now()).obs;


  RxBool isActive = false.obs;



  @override
  void onInit() {
    super.onInit();
    selectedProfile.value =
        LocaleManager.getValue(StorageKeys.profile) ??'';
  }
}
