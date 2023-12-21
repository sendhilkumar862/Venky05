

import 'package:hessah/core/api_end_points.dart';
import 'package:hessah/core/backend_service.dart';
import 'package:hessah/core/base_request.dart';
import 'package:hessah/core/base_response.dart';

import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../Model/get_address_model.dart';


class UpdateAddressRepository{
  Future<BaseResponse>  updateAddressRepository( UserAddress userAddress) async {
    try {
      return await BackendService.post(
          UpdateAddressAPIRequest(userAddress: userAddress));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class  UpdateAddressAPIRequest extends BaseRequest {
  UpdateAddressAPIRequest({required this.userAddress});
  UserAddress userAddress;

  @override
  String get endPoint =>'${ApiEndpoint.auth(AuthEndpoint.USER_ADDRESS)}:addressId';
  @override
  Map<String, dynamic> get body => userAddress.toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.PUT;
}