import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';


import '../../../../core/base_response.dart';
import '../../../../product/utils/validators.dart';
import '../../../home/controller/home_controller.dart';
import '../repository/change_name_repository.dart';


class ChangeNameController  extends GetxController{
  RxBool isDisable=true.obs;
  RxString error=''.obs;
  RxString loginStatus = ''.obs;
  RxInt changeNameValid = 2.obs;
  RxString changeNameErrorText = ''.obs;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  final HomeController _homeController = Get.find();

  final ChangeNameRepository _chaneNameRepository = ChangeNameRepository();

  @override
  void onInit() {
    firstName.text=_homeController.homeData.value?.firstName??'';
    lastName.text=_homeController.homeData.value?.lastName??'';
    super.onInit();
  }
  Future<bool> changeName() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse signInResponse = await _chaneNameRepository.nameChange(firstName: firstName.text, lastName: lastName.text);
    if (signInResponse.status?.type == 'success') {
      EasyLoading.dismiss();
      _homeController.fetchData();
      return true;
    } else {
      loginStatus.value=signInResponse.status?.type??'';
      error.value = signInResponse.status?.message ?? '';
      EasyLoading.dismiss();
      return false;
    }
  }
}