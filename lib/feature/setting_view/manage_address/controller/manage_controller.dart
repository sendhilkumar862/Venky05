import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/base_response.dart';
import '../Model/get_address_model.dart';
import '../repository/get_address_repository.dart';

class ManageAddressController extends GetxController{
  RxList<UserAddress> address=<UserAddress>[].obs;
  final GetAddressRepository _getAddressRepository=GetAddressRepository();
  @override
  void onInit() {
    super.onInit();
    fetchAddressData();
  }


  Future<void> fetchAddressData() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse getProfileIDResponse = await _getAddressRepository.getAddressRepository();
    if (getProfileIDResponse.status?.type == 'success') {
      List data =getProfileIDResponse.data?.item as List;
      address.clear();
      for (var element in data) {
        address.add(UserAddress.fromJson(element));
      }
    } else {
    }
    EasyLoading.dismiss();
  }
}