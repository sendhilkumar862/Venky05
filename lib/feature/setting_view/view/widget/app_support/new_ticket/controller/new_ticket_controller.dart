import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../../../../core/base_response.dart';
import '../repository/master_data_app_support_repository.dart';

class NewTicketController extends GetxController{

 final GetMasterDataAppSupportRepository _getMasterDataAppSupportRepository=GetMasterDataAppSupportRepository();

 Rx<List<String>> masterData = <String>[].obs as Rx<List<String>> ;

 Future<void> getMasterDataClass() async {
   EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
   final BaseResponse masterDataResponse = await _getMasterDataAppSupportRepository.getMasterDataAppSupport();
   if (masterDataResponse.status?.type == 'success') {
     // ignore: always_specify_types
     final List data=masterDataResponse.data!.item! as List;
     for (var element in data) {
       masterData.value.add(element);
     }
   } else {
   }
   EasyLoading.dismiss();
 }
}