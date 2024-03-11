

import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../model/get_class_list_request_model.dart';



class GetFavouriteListRepository {
  Future<BaseResponse> getFavouriteList (GetClassRequestModel getFavouritesRequestModel) async {
    try {
      return await BackendService.post(
          FavouriteListAPIRequest(getFavouritesRequestModel: getFavouritesRequestModel));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class FavouriteListAPIRequest extends BaseRequest {
  FavouriteListAPIRequest({required this.getFavouritesRequestModel});
  final GetClassRequestModel getFavouritesRequestModel;

  @override
  String get endPoint => ApiEndpoint.favourites(FavouritesEndPoint.Favourites);
  @override
  Map<String, dynamic> get body => getFavouritesRequestModel.toJson();


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.POST;
}