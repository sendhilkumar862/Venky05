
import 'package:get/get.dart';

import '../../../core/base_response.dart';
import '../../../custom/loader/easy_loader.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../model/home_model.dart';
import '../repository/get_dashboard_detail_repository.dart';

class HomeController extends GetxController {
  final KeyValueStorageService keyValueStorageService =
      KeyValueStorageService();
  final GetDashboardDetailRepository _dashboardDetailRepository = GetDashboardDetailRepository();
  // ignore: always_declare_return_types
  fetchToken() async {
    final String token = await keyValueStorageService.getAuthToken();
    if (token != '') {
      fetchData();
    }
  }
  Rx<HomeModel?> homeData = const HomeModel().obs;
  Future<void> fetchData() async {
    showLoading();
    final BaseResponse dashboardDataResponse = await _dashboardDetailRepository.getDashboardDetail();
    if (dashboardDataResponse.status?.type == 'success') {
      final  Map<String, dynamic> dashBoardData=dashboardDataResponse.data!.item! as Map<String ,dynamic>;
      homeData.value = HomeModel.fromJson(dashBoardData);
    }
    hideLoading();
  }
}
