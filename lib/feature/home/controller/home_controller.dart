
import 'package:get/get.dart';

import '../../../core/base_response.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/cache/key_value_storeage.dart';
import '../../../product/cache/local_manager.dart';
import '../../tutorial/login/model/refresh_model.dart';
import '../model/getClassList.dart';
import '../model/get_class_list_request_model.dart';
import '../model/home_model.dart';
import '../repository/get_class_list_repository.dart';
import '../repository/get_dashboard_detail_repository.dart';
import '../repository/refersh_token_repository.dart';


class HomeController extends GetxController {

  final GetDashboardDetailRepository _dashboardDetailRepository = GetDashboardDetailRepository();
  final GetClassListRepository _getClassListRepository = GetClassListRepository();
  final RefreshTokenRepositoryRepository _refreshTokenRepositoryRepository = RefreshTokenRepositoryRepository();
  RxBool isCreatedClass = false.obs;
  // ignore: always_declare_return_types
  fetchToken() async {
    final String token = LocaleManager.getAuthToken() ?? '';
    if (token != '') {
      getData();
      isCreatedClass.value =
          LocaleManager.getValue(StorageKeys.createdClass) ??false;
    }
  }



  getData()async{
    showLoading();
    await Future.wait([
    fetchData(),
    getClassList()
    ]);
    hideLoading();
  }

  Rx<HomeModel?> homeData = const HomeModel().obs;
  RxList upComingClassList = [].obs;
  RxList historyClassList = [1].obs;
  RxList favouriteTeachersList = [].obs;
  RxList relatedTeachersList = [].obs;
  RxList favouriteStudentsList = [].obs;
  RxList relatedStudentsList = [].obs;
  RxList activitiesList = [].obs;


  Future<void> fetchData() async {
    final BaseResponse dashboardDataResponse = await _dashboardDetailRepository.getDashboardDetail();
    if (dashboardDataResponse.status?.type == 'success') {
      final  Map<String, dynamic> dashBoardData=dashboardDataResponse.data!.item! as Map<String ,dynamic>;
      homeData.value = HomeModel.fromJson(dashBoardData);
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


  RxList<GetClassListModel> classList = <GetClassListModel>[].obs;

  Future<void> getClassList() async {
    final BaseResponse classListDataResponse = await _getClassListRepository.getClassList(GetClassRequestModel(limit: '30',startIndex: '1',sortColumn:'created_at',sortDirection: 'desc' ));
    if (classListDataResponse.status?.type == 'success') {
      final List classListData=classListDataResponse.data!.item! as List;
      classList.clear();
      for (var element in classListData) {
        classList.add(GetClassListModel.fromJson(element));
      }
    }
  }
}
