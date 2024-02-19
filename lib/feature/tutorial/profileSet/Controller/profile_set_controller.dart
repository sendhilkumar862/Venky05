import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../config/routes/route.dart';
import '../../../../core/base_response.dart';
import '../../../../custom/loader/easy_loader.dart';
import '../../../../product/cache/key_value_storage.dart';
import '../../../../product/cache/local_manager.dart';
import '../../onboarding/Controller/onboading_controller.dart';
import '../model/about_model.dart';
import '../repository/profile_set_repository.dart';

class ProfileSetController extends GetxController {
  final ProfileSetRepository _profileSetRepository = ProfileSetRepository();
  final OnBoadingController _onBoadingController =Get.put(OnBoadingController());

  @override
  void onInit() {
    super.onInit();
    fetchData();

  }


  RxInt selectedIndex = 2.obs;

  RxList<String> profileItems = <String>['teacher'.tr, 'parent'.tr].obs;

  RxList<AboutModel> data = <AboutModel>[].obs;

  void selectProfile(int index) {
    selectedIndex.value = index;
  }

  void onTapSubmit() {
    if (selectedIndex.value != 2) {
      LocaleManager.setValue( StorageKeys.profile, selectedIndex == 0 ? 'Tutor' : 'Student');
      _onBoadingController.currentProfile.value=selectedIndex == 0 ? 'Tutor' : 'Student';
      Get.toNamed(Routes.onBoardingView);
    }
  }

  Future<void> fetchData() async {
    showLoading();
    final BaseResponse profileResponse =
        await _profileSetRepository.profileSet();
    if (profileResponse.status?.type == 'success') {
      // ignore: always_specify_types
      final List responseData = profileResponse.data!.item! as List;
      data.clear();
      for (var element in responseData) {
        data.add(AboutModel.fromJson(element));
      }
    } else {}
    EasyLoading.dismiss();
  }
}
