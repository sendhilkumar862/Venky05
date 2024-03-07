import '../../../../core/api_end_points.dart';
import '../../../../core/backend_service.dart';
import '../../../../core/base_request.dart';
import '../../../../core/base_response.dart';
import '../../../../core/hessah_exception.dart';
import '../../../../product/constants/enums/backend_services_method_enums.dart';
import '../../home/model/get_class_list_request_model.dart';


class DeleteFavouritesRepository {
  Future<BaseResponse> deleteFavourites (String id) async {
    try {
      return await BackendService.post(
          DeleteFavouriteAPIRequest(id:id));
    } catch (e) {
      if (e is HessahException) {
        return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
      }
      return BaseResponse(status: Status(type: 'error', message: 'Something went wrong'));
    }
  }
}
class DeleteFavouriteAPIRequest extends BaseRequest {
  DeleteFavouriteAPIRequest({required this.id});
  final String id;

  @override
  String get endPoint => '${ApiEndpoint.favourites(FavouritesEndPoint.Favourites)}/$id';
  @override
  Map<String, dynamic> get body => {};


  @override
  // TODO: implement apiMethod
  BackEndServicesEnum get apiMethod =>BackEndServicesEnum.DELETE;
}