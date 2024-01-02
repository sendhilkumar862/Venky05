

import 'package:hessah/core/api_end_points.dart';
import 'package:hessah/core/backend_service.dart';
import 'package:hessah/core/base_request.dart';
import 'package:hessah/core/base_response.dart';

import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../Model/request_address_model.dart';


class AddAddressRepository{
  Future<BaseResponse> addAddressRepository( AddressRequestModel address) async {
    try {
      return await BackendService.post(
          AddAddressAPIRequest(address: address));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}

class AddAddressAPIRequest extends BaseRequest {
  AddAddressAPIRequest({required this.address});
  final AddressRequestModel address;

  @override
  String get endPoint => ApiEndpoint.auth(AuthEndpoint.USER_ADDRESS);
  @override
  Map<String, dynamic> get body => address.toJson();

  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}