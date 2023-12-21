import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/base_response.dart';
import '../Model/get_address_model.dart';
import '../repository/delete_address_repository.dart';
import '../repository/get_address_repository.dart';
import '../repository/update_address_repository.dart';

class ManageAddressController extends GetxController{
  RxList<UserAddress> address=<UserAddress>[].obs;
  final GetAddressRepository _getAddressRepository=GetAddressRepository();
  final DeleteAddressRepository _deleteAddressRepository=DeleteAddressRepository();
  final UpdateAddressRepository _updateAddressRepository=UpdateAddressRepository();


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
  Future<void> deleteAddressData(int id) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse getProfileIDResponse = await _deleteAddressRepository.deleteAddressRepository(id);
    if (getProfileIDResponse.status?.type == 'success') {
      await fetchAddressData();
    } else {
    }
    EasyLoading.dismiss();
  }
  Future<void> updateAddressData( UserAddress userAddress) async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    final BaseResponse getProfileIDResponse = await _updateAddressRepository.updateAddressRepository(userAddress,userAddress.id!);
    if (getProfileIDResponse.status?.type == 'success') {
      await fetchAddressData();
    } else {
    }
    EasyLoading.dismiss();
  }
}