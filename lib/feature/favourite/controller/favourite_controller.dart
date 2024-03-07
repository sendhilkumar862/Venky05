import 'package:get/get.dart';

import '../../../core/base_response.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../home/model/get_class_list_request_model.dart';
import '../model/favourites_data_model.dart';
import '../repository/add_favourites_repository.dart';
import '../repository/delete_favourites_repository.dart';
import '../repository/get_favourites_repository.dart';

class FavouriteController extends GetxController{
  final GetFavouriteListRepository _getFavouriteListRepository=GetFavouriteListRepository();
  final AddFavouritesRepository _addFavouritesRepository=AddFavouritesRepository();
  final DeleteFavouritesRepository _deleteFavouriteAPIRequest=DeleteFavouritesRepository();
  RxList<FavouritesModel> favouritesList=<FavouritesModel>[].obs;

  Future<void> getFavouriteInfo(GetClassRequestModel data) async {
    showLoading();
    final BaseResponse getFavouriteInfoDataResponse =
    await _getFavouriteListRepository.getFavouriteList(data);
    if (getFavouriteInfoDataResponse.status?.type == 'success') {
      // ignore: always_specify_types
      final List favouritesListData=getFavouriteInfoDataResponse.data!.item! as List;
      // ignore: always_specify_types
      for (final element in favouritesListData) {
        favouritesList.add(FavouritesModel.fromJson(element));
      }

    }
    hideLoading();
  }

  Future<void> addFavouriteInfo(String  id) async {
    showLoading();
    final BaseResponse addFavouriteInfoDataResponse =
    await _addFavouritesRepository.addFavourites(id);
    if (addFavouriteInfoDataResponse.status?.type == 'success') {
      if (addFavouriteInfoDataResponse.data!.item != null) {

      }
    }
    hideLoading();

  }

  Future<void> deleteFavouriteInfo(String  id) async {
    showLoading();
    final BaseResponse deleteFavouriteInfoDataResponse =
    await _deleteFavouriteAPIRequest.deleteFavourites(id);
    if (deleteFavouriteInfoDataResponse.status?.type == 'success') {
      if (deleteFavouriteInfoDataResponse.data!.item != null) {

      }
    }
    hideLoading();

  }


}
