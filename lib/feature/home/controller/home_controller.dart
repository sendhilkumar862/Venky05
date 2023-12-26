import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../custom/loader/easy_loader.dart';
import '../../../product/base/model/base_model.dart';
import '../../../product/network/local/key_value_storage_base.dart';
import '../../../product/network/local/key_value_storage_service.dart';
import '../model/home_model.dart';

class HomeController extends GetxController{
  final KeyValueStorageService keyValueStorageService =
  KeyValueStorageService();
// @override
// void onInit() {
//   super.onInit();
//   fetchToken();
// }
 // ignore: always_declare_return_types
 fetchToken()async{
   final String token = await keyValueStorageService.getAuthToken();
   if(token!=''){
     fetchData();
   }

 }
Future<Options> _headers() async {
  final KeyValueStorageService keyValueStorageService =
  KeyValueStorageService();
  final String token = await keyValueStorageService.getAuthToken();
  return Options(
    headers: <String, String>{
      'Content-Type': 'application/json',
      'X-Auth-Token': token,
    },
  );
}

 Rx<HomeModel?> homeData = HomeModel().obs;


Future<void> fetchData() async {
  final KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  showLoading();
  final Dio dio = Dio();
  try {
    final Response response = await dio.get(
      'http://167.99.93.83/api/v1/users/dashboard/details',
      options: await _headers(),
    );
    if (response.statusCode == 200) {
      final BaseResponse<HomeModel> baseResponse =
      BaseResponse<HomeModel>.fromJson(response.data as Map<String, dynamic>, HomeModel.fromJson);
      keyValueStorageBase.setCommon(KeyValueStorageService.userInfoStatus,baseResponse.data.item?.userStatus );
      homeData.value=baseResponse.data.item ;
      hideLoading();
    } else {
      hideLoading();
    }
  } on DioException {
    hideLoading();
  }
}
}
