
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/api_end_points.dart';
import '../../../core/base_response.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../mirrorfly/mirrorFlyController/mirrorfly_auth_controller.dart';
import '../../../product/cache/key_value_storage.dart';
import '../../../product/cache/local_manager.dart';
import '../../classDetails/repository/book_class_repository.dart';
import '../../tutorial/login/model/refresh_model.dart';
import '../repository/add_favourites_repository.dart';
import '../repository/delete_favourites_repository.dart';
import '../repository/get_class_list_repository.dart';
import '../repository/get_dashboard_detail_repository.dart';
import '../repository/get_favourites_repository.dart';
import '../repository/model/favourites_data_model.dart';
import '../repository/model/getClassList.dart';
import '../repository/model/get_class_list_request_model.dart';
import '../repository/model/home_model.dart';
import '../repository/refersh_token_repository.dart';


class HomeController extends GetxController {

  final GetDashboardDetailRepository _dashboardDetailRepository = GetDashboardDetailRepository();
  final GetClassListRepository _getClassListRepository = GetClassListRepository();
  final BookClassRepository _bookClassRepository=BookClassRepository();
  final RefreshTokenRepositoryRepository _refreshTokenRepositoryRepository = RefreshTokenRepositoryRepository();
  final GetFavouriteListRepository _getFavouriteListRepository=GetFavouriteListRepository();
  final AddFavouritesRepository _addFavouritesRepository=AddFavouritesRepository();
  final DeleteFavouritesRepository _deleteFavouriteAPIRequest=DeleteFavouritesRepository();
  RxBool isCreatedClass = false.obs;
  ScrollController scrollController = ScrollController();
  RxDouble childAspectRatio=0.65.obs;
  final MirrorFlyAuthController _mirrorFlyAuthController=Get.put(MirrorFlyAuthController());
  // ignore: always_declare_return_types
  fetchToken() async {
    final String token = LocaleManager.getAuthToken() ?? '';
    if (token != '') {
      getData();
      isCreatedClass.value =
          LocaleManager.getValue(StorageKeys.createdClass) ??false;
    }
  }

@override
void onInit(){
  super.onInit();
  fetchData();
  getFavouriteInfo(favouritePageIndex);
}

  getData()async{
    showLoading();
    await Future.wait(<Future<void>>[
    fetchData(),
    getClassList(SchoolEndpoint.GET, 1),
      getClassList(SchoolEndpoint.UPCOMING_CLASS,upcomingPageIndex),
      getClassList(SchoolEndpoint.HISTORY_CLASS,historyPageIndex),
      getClassList(SchoolEndpoint.ACTIVITY_CLASS,activityPageIndex),
      getClassList(SchoolEndpoint.RELATED_CLASS,relatedPageIndex),
      getFavouriteInfo(favouritePageIndex),
    ]);
    hideLoading();
  }

  Rx<HomeModel?> homeData = const HomeModel().obs;
  RxList<String> favouriteTeachersList = <String>[].obs;
  RxList<String> relatedTeachersList = <String>[].obs;
  RxList<String> favouriteStudentsList = <String>[].obs;
  RxList<String> relatedStudentsList = <String>[].obs;
  RxList<GetClassListModel> classList = <GetClassListModel>[].obs;
  RxList<GetClassListModel> classUpcomingList = <GetClassListModel>[].obs;
  RxList<GetClassListModel> classHistoryList = <GetClassListModel>[].obs;
  RxList<GetClassListModel> classActivityList = <GetClassListModel>[].obs;
  RxList<GetClassListModel> classRelatedList = <GetClassListModel>[].obs;
  RxList<FavouritesModel> favouritesList=<FavouritesModel>[].obs;


  int totalUpcomingCount=0;
  int upcomingPageIndex=1;

  int totalHistoryCount=0;
  int historyPageIndex=1;

  int totalActivityCount=0;
  int activityPageIndex=1;

  int totalRelatedCount=0;
  int relatedPageIndex=1;

  int totalRelatedStudentCount=0;
  int totalFavouriteStudentCount=0;

  int totalRelatedTeacherCount=0;

  int totalFavouriteCount=0;
  int favouritePageIndex=1;


  Future<void> fetchData() async {
    final BaseResponse dashboardDataResponse = await _dashboardDetailRepository.getDashboardDetail();
    if (dashboardDataResponse.status?.type == 'success') {
      final  Map<String, dynamic> dashBoardData=dashboardDataResponse.data!.item! as Map<String ,dynamic>;
      homeData.value = HomeModel.fromJson(dashBoardData);
      await _mirrorFlyAuthController.updateProfile('${homeData.value?.firstName??''} ${homeData.value?.lastName??''}',homeData.value?.email??'');
    }
  }
  Future<void> refreshToken() async {
    showLoading();
    final BaseResponse signInResponse =
    await _refreshTokenRepositoryRepository.refreshToken();
    if (signInResponse.status?.type == 'success') {
      final RefreshModelClass responseData = RefreshModelClass.fromJson(
          signInResponse.data!.item! as Map<String, dynamic>);
      if (responseData.auth?.accessToken?.isNotEmpty ?? false) {
        LocaleManager
            .setAuthToken(responseData.auth?.accessToken ?? '');
        fetchToken();
      }
    } else {
      hideLoading();
    }
  }


  Future<void> getClassList(SchoolEndpoint schoolEndpoint,int startIndex,{bool isReload=false}) async {
    if(isReload){
      showLoading();
    }
    final BaseResponse classListDataResponse = await _getClassListRepository.getClassList(GetClassRequestModel(limit: '10',startIndex: startIndex.toString(),sortColumn:'created_at',sortDirection: 'desc' ),schoolEndpoint);
    if (classListDataResponse.status?.type == 'success') {
      // ignore: always_specify_types
      final List classListData=classListDataResponse.data!.item! as List;

     if(schoolEndpoint==SchoolEndpoint.GET){
       if(!isReload) {
         classList.clear();
       }
      // ignore: always_specify_types
      for (final element in classListData) {
        classList.add(GetClassListModel.fromJson(element));
      }}
     else if(schoolEndpoint==SchoolEndpoint.UPCOMING_CLASS){
       if(!isReload) {
       classUpcomingList.clear();}
       totalUpcomingCount=classListDataResponse.paginationData?.total??0;
       // ignore: always_specify_types
       for (final element in classListData) {
         classUpcomingList.add(GetClassListModel.fromJson(element));
       }} else if(schoolEndpoint==SchoolEndpoint.HISTORY_CLASS){
       if(!isReload) {
       classHistoryList.clear();}
       totalHistoryCount=classListDataResponse.paginationData?.total??0;
       // ignore: always_specify_types
       for (final element in classListData) {
         classHistoryList.add(GetClassListModel.fromJson(element));
       }} else if(schoolEndpoint==SchoolEndpoint.ACTIVITY_CLASS){
       if(!isReload) {classActivityList.clear();}
       totalActivityCount=classListDataResponse.paginationData?.total??0;
       // ignore: always_specify_types
       for (final element in classListData) {
         classActivityList.add(GetClassListModel.fromJson(element));
       }} else if(schoolEndpoint==SchoolEndpoint.RELATED_CLASS){
       if(!isReload) {classRelatedList.clear();}
       totalRelatedCount=classListDataResponse.paginationData?.total??0;
       // ignore: always_specify_types
       for (final element in classListData) {
         classRelatedList.add(GetClassListModel.fromJson(element));
       }}

    }
    if(isReload){
      hideLoading();
    }
  }




  Future<void> getFavouriteInfo(int startIndex,{bool isReload=false}) async {
  if(isReload){
  showLoading();
  }
    final BaseResponse getFavouriteInfoDataResponse =
    await _getFavouriteListRepository.getFavouriteList(GetClassRequestModel(limit: '10',startIndex: startIndex.toString(),sortColumn:'created_at',sortDirection: 'desc' ));
    if (getFavouriteInfoDataResponse.status?.type == 'success') {
      // ignore: always_specify_types
      final List favouritesListData=getFavouriteInfoDataResponse.data!.item! as List;

      if(!isReload) {
        favouritesList.clear();}
      totalFavouriteCount=getFavouriteInfoDataResponse.paginationData?.total??0;
      // ignore: always_specify_types
      for (final element in favouritesListData) {
        favouritesList.add(FavouritesModel.fromJson(element));
      }

    }
  if(isReload){
    hideLoading();
  }
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
